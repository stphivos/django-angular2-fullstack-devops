variable "app_env" {
  default = "<dynamic>"
}

variable "app_name" {
  default = "<dynamic>"
}

variable "aws_region" {
  default = "<dynamic>"
}

variable "aws_zone_id" {
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
  aws_zone_id = "${var.aws_zone_id}"
}
