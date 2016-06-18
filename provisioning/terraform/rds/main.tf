provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  # TODO: Remove the following after setup
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

resource "aws_subnet" "subnet_1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true
}

resource "aws_db_subnet_group" "default" {
  name = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids = [
    "${aws_subnet.subnet_1.id}",
    "${aws_subnet.subnet_2.id}"]
}

resource "aws_security_group" "default" {
  name = "${var.app_name}_sg_rds"
  description = "Used in the terraform"
  vpc_id = "${aws_vpc.default.id}"

  # ssh access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # postgres access
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # outbound access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_db_instance" "default" {
  depends_on = [
    "aws_security_group.default"]
  identifier = "${var.identifier}"
  allocated_storage = "${var.storage}"
  engine = "${var.engine}"
  engine_version = "${lookup(var.engine_version, var.engine)}"
  instance_class = "${var.instance_class}"
  name = "${var.db_name}_${var.app_env}"
  username = "${var.username}"
  password = "${var.password}"
  vpc_security_group_ids = [
    "${aws_security_group.default.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  # TODO: Remove the following after setup
  publicly_accessible = true
}