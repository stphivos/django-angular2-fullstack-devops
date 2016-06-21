provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_db_subnet_group" "default" {
  name = "${var.app_name}_subnet_group_${var.app_env}"
  description = "Our main group of subnets"
  subnet_ids = [
    "${var.default_subnet_id}",
    "${var.secondary_subnet_id}"]
}

resource "aws_security_group" "default" {
  name = "${var.app_name}_sg_rds_${var.app_env}"
  description = "Used in the terraform"
  vpc_id = "${var.vpc_id}"

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
  identifier = "${var.identifier}-${var.app_env}"
  allocated_storage = "${var.storage}"
  engine = "${var.engine}"
  engine_version = "${lookup(var.engine_version, var.engine)}"
  instance_class = "db.${var.instance_class}"
  name = "${var.db_name}"
  username = "${var.db_username}"
  password = "${var.db_password}"
  vpc_security_group_ids = [
    "${aws_security_group.default.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  # TODO: Remove the following after setup to prevent internet access to db instances
  publicly_accessible = true
}
