variable "app_name" {
  description = "Name of the app to provision"
  default = "fullstack"
}

variable "app_env" {
  description = "Name of the app environment to provision"
  default = "dev"
}

variable "key_name" {
  description = "Name of EC2 keypair to login to the instance"
  default = "fullstack"
  # TODO: Get keypair from environment variables
}

variable "public_key_path" {
  description = "Path of keypair's public key file"
  default = "~/.ssh/fullstack.pub"
  # TODO: Get public key file from environment variables (Also see pack.json)
}

variable "private_key_path" {
  description = "Path of keypair's private key file"
  default = "~/.ssh/fullstack.pem"
  # TODO: Get private key file from environment variables (Also see pack.json)
}

variable "user" {
  description = "User to login to the ami for provisioning"
  default = "ubuntu"
  # TODO: Get ssh_user from environment variables
}

variable "instance_type" {
  description = "Size of the instance to create"
  default = "t2.micro"
  # TODO: Get instance_type from environment variables
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-central-1"
}

variable "aws_amis" {
  description = "Amazon Machine Image (AMI) ids produced by packer"
  default = {
    eu-central-1 = "<terraform.tfvars>"
  }
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
  default = "Z3BXIXH96UUDRV"
  # TODO: Get zone id from environment variables
}
