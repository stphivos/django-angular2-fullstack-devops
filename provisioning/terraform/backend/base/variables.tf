variable "vpc_id" {
  description = "VPC id"
  default = "<dynamic>"
}

variable "default_subnet_id" {
  description = "Default subnet id"
  default = "<dynamic>"
}

variable "app_name" {
  description = "Name of the app to provision"
  default = "<dynamic>"
}

variable "app_env" {
  description = "Name of the app environment to provision"
  default = "<dynamic>"
}

variable "key_name" {
  description = "Name of EC2 keypair to login to the instance"
  default = "<dynamic>"
}

variable "private_key_path" {
  description = "Path of keypair's private key file"
  default = "<dynamic>"
}

variable "user" {
  description = "User to login to the ami for provisioning"
  default = "<dynamic>"
}

variable "instance_type" {
  description = "Size of the instance to create"
  default = "<dynamic>"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "<dynamic>"
}

variable "aws_ami" {
  description = "Amazon Machine Image (AMI) id produced by packer"
  default = "<dynamic>"
}

variable "aws_env_domains" {
  description = "Domains for all environments"
  default = {
    prod = "api"
    dev = "dev.api"
  }
}

variable "aws_zone_id" {
  description = "Route53 Hosted Zone resource id."
  default = "<dynamic>"
}
