variable "app_name" {
  description = "Name of the app to provision"
  default = "<dynamic>"
}

variable "key_name" {
  description = "Name of EC2 keypair to login to the instance"
  default = "<dynamic>"
}

variable "public_key_path" {
  description = "Path of keypair's public key file"
  default = "<dynamic>"
}

variable "private_key_path" {
  description = "Path of keypair's private key file"
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

variable "aws_zone_id" {
  description = "Route53 Hosted Zone resource id."
  default = "<dynamic>"
}
