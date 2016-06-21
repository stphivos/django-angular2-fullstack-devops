variable "vpc_id" {
  default = "<dynamic>"
}

variable "default_subnet_id" {
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

variable "instance_type" {
  default = "<dynamic>"
}

variable "user" {
  default = "<dynamic>"
}

variable "aws_zone_id" {
  default = "<dynamic>"
}

variable "key_name" {
  default = "<dynamic>"
}

variable "public_key_path" {
  default = "<dynamic>"
}

variable "private_key_path" {
  default = "<dynamic>"
}

variable "aws_amis" {
  default = {
    eu-central-1 = "<dynamic>"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

module "base" {
  source = "../base"

  vpc_id = "${var.vpc_id}"
  default_subnet_id = "${var.default_subnet_id}"
  app_env = "${var.app_env}"
  app_name = "${var.app_name}"
  aws_region = "${var.aws_region}"
  instance_type = "${var.instance_type}"
  user = "${var.user}"
  aws_zone_id = "${var.aws_zone_id}"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
  aws_ami = "${var.aws_amis.eu-central-1}"
}
