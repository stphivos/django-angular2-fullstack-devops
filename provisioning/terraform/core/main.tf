# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
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

# Create subnets to launch our instances into
resource "aws_subnet" "default" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "secondary" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

//// Temporarilly disable devops instance
//resource "aws_route53_record" "devops" {
//  zone_id = "${var.aws_zone_id}"
//  name = "devops"
//  type = "A"
//  ttl = "300"
//  records = [
//    "${aws_instance.jenkins.public_ip}"]
//}
//
//# A security group for the ELB so it is accessible via the web
//resource "aws_security_group" "devops" {
//  name = "${var.app_name}_sg_devops"
//  description = "Used in the terraform"
//  vpc_id = "${aws_vpc.default.id}"
//
//  # HTTP access from anywhere
//  ingress {
//    from_port = 80
//    to_port = 80
//    protocol = "tcp"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//
//  # SSH access from anywhere
//  ingress {
//    from_port = 22
//    to_port = 22
//    protocol = "tcp"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//
//  # outbound internet access
//  egress {
//    from_port = 0
//    to_port = 0
//    protocol = "-1"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//}
//
//resource "aws_instance" "jenkins" {
//  # The connection block tells our provisioner how to
//  # communicate with the resource (instance)
//  connection {
//    # The default username for our AMI
//    user = "bitnami"
//    private_key = "${file(var.private_key_path)}"
//    agent = false
//  }
//
//  instance_type = "${var.instance_type}"
//
//  # https://bitnami.com/stack/jenkins/cloud/aws
//  ami = "ami-6824ca07"
//
//  # The name of our SSH keypair we created above.
//  key_name = "${aws_key_pair.auth.id}"
//
//  # Our Security group to allow HTTP and SSH access
//  vpc_security_group_ids = [
//    "${aws_security_group.devops.id}"]
//
//  # We're going to launch into the same subnet as our ELB. In a production
//  # environment it's more common to have a separate private subnet for
//  # backend instances.
//  subnet_id = "${aws_subnet.default.id}"
//}
