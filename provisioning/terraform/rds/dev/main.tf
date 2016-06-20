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
  app_env = "${var.app_env}"
  app_name = "${var.app_name}"
  aws_region = "${var.aws_region}"
  db_name = "${var.db_name}"
  db_username = "${var.db_username}"
  db_password = "${var.db_password}"
  instance_class = "${var.instance_class}"
}
