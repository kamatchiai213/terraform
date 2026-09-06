variable "ami" {
  description = "The AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to use"
}

variable "tag_name" {
  description = "The name tag for the instance"
}


variable "availability_zone" {
  description = "The availability zone to launch the instance in"
}

variable "key_name" {
  description = "The key pair name to use for the instance"
}

variable "vpc_cidr_blocks" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "cidr_blocks" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "subnet_cidr_blocks" {
  description = "The CIDR block for the subnet"
  type = string
}

