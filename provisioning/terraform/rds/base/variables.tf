variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-central-1"
}

variable "app_name" {
  description = "Name of the app to provision"
  default = "fullstack"
}

variable "app_env" {
  description = "Name of the app environment to provision"
  default = "dev"
}

variable "identifier" {
  default = "fullstack-rds"
  description = "Identifier for your DB"
}

variable "storage" {
  default = "10"
  description = "Storage size in GB"
}

variable "engine" {
  default = "postgres"
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
  description = "Engine version"
  default = {
    mysql = "5.6.22"
    postgres = "9.5.2"
  }
}

variable "instance_class" {
  default = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default = "fullstack"
  description = "db name"
}

variable "username" {
  default = "fullstack"
  description = "User name"
}

variable "password" {
  description = "Password"
  default = "!qwerty1"
  # TODO: Provide through ENV variables
}
