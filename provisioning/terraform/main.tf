# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name = "${var.app_name}_sg_elb"
  description = "Used in the terraform"
  vpc_id = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name = "${var.app_name}_sg_default"
  description = "Used in the terraform"
  vpc_id = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}


resource "aws_elb" "web" {
  name = "${var.app_name}-elb-web"

  subnets = [
    "${aws_subnet.default.id}"]
  security_groups = [
    "${aws_security_group.elb.id}"]
  instances = [
    "${aws_instance.web.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}

// TODO: Point frontend route53 record to S3
//resource "aws_route53_record" "frontend" {
//  zone_id = "${var.aws_zone_id}"
//  name = "example.com"
//  type = "A"
//
//  alias {
//    name = "${aws_elb.web.dns_name}"
//    zone_id = "${aws_elb.web.zone_id}"
//    evaluate_target_health = true
//  }
//}

resource "aws_route53_record" "backend" {
  zone_id = "${var.aws_zone_id}"
  name = "${lookup(var.aws_env_domains, "${var.app_env}_backend")}"
  type = "A"

  alias {
    name = "${aws_elb.web.dns_name}"
    zone_id = "${aws_elb.web.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.user}"
    private_key = "${file(var.private_key_path)}"
    agent = false
  }

  instance_type = "${var.instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [
    "${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"
}

resource "aws_route53_record" "devops" {
  zone_id = "${var.aws_zone_id}"
  name = "devops"
  type = "A"
  ttl = "300"
  records = [
    "${aws_instance.jenkins.public_ip}"]
}

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "devops" {
  name = "${var.app_name}_sg_devops"
  description = "Used in the terraform"
  vpc_id = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "bitnami"
    private_key = "${file(var.private_key_path)}"
    agent = false
  }

  instance_type = "${var.instance_type}"

  # https://bitnami.com/stack/jenkins/cloud/aws
  ami = "ami-6824ca07"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [
    "${aws_security_group.devops.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"
}
