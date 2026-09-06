variable "ami"  {
  description = "The AMI to use for the instance"

}

variable "instance_type" {
  description = "The type of instance to use"
}

variable "tag_name" {
  description = "The name tag for the instance"
  default     = "terraform"
}

variable security_group_id {
  description = "The security group ID to associate with the instance"
}

variable vpc_id {
  description = "The VPC ID to launch the instance in"
}

