variable "vpc_id" {
  description = "VPC id"
  default = "<dynamic>"
}

variable "default_subnet_id" {
  description = "Default subnet id"
  default = "<dynamic>"
}

variable "secondary_subnet_id" {
  description = "Secondary subnet id"
  default = "<dynamic>"
}

variable "aws_region" {
  description = "AWS region to launch servers."
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

variable "identifier" {
  description = "Identifier for your DB"
  default = "fullstack-rds"
}

variable "storage" {
  description = "Storage size in GB"
  default = "10"
}

variable "engine" {
  description = "Engine type, example values mysql, postgres"
  default = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  default = {
    mysql = "5.6.22"
    postgres = "9.5.2"
  }
}

variable "instance_class" {
  description = "Instance class"
  default = "<dynamic>"
}

variable "db_name" {
  description = "Database name"
  default = "<dynamic>"
}

variable "db_username" {
  description = "Database username"
  default = "<dynamic>"
}

variable "db_password" {
  description = "Database password"
  default = "<dynamic>"
}
