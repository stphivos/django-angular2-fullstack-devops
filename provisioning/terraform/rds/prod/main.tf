variable "vpc_id" {
  default = "<dynamic>"
}

variable "default_subnet_id" {
  default = "<dynamic>"
}

variable "secondary_subnet_id" {
  default = "<dynamic>"
}

variable "app_env" {
  default = "<dynamic>"
}

variable "app_name" {
  default = "<dynamic>"
}

variable "aws_region" {
  default = "<dynamic>"
}

variable "db_name" {
  default = "<dynamic>"
}

variable "db_username" {
  default = "<dynamic>"
}

variable "db_password" {
  default = "<dynamic>"
}

variable "instance_class" {
  default = "<dynamic>"
}

provider "aws" {
  region = "${var.aws_region}"
}

module "base" {
  source = "../base"

  vpc_id = "${var.vpc_id}"
  default_subnet_id = "${var.default_subnet_id}"
  secondary_subnet_id = "${var.secondary_subnet_id}"
  app_env = "${var.app_env}"
  app_name = "${var.app_name}"
  aws_region = "${var.aws_region}"
  db_name = "${var.db_name}"
  db_username = "${var.db_username}"
  db_password = "${var.db_password}"
  instance_class = "${var.instance_class}"
}
