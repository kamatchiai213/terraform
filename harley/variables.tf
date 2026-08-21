variable "ami" {
  description = "The AMI to use for the instance"
  default     = "ami-0705ee59abc1fde2c"
}

variable "instance_type" {
  description = "The type of instance to use"
  default     = "t3.micro"
}

variable "tags_name" {
  description = "The name tag for the instance"
  default     = "webserver"
}

