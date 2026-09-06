variable ami {
  description = "The AMI to use for the instance"
}

variable instance_type {
  description = "The type of instance to use"
}

variable tag_name {
  description = "The name tag for the instance"

}

variable ebs_size {
  description = "The size of the EBS volume in GB"
}

variable availability_zone {
  description = "The availability zone to launch the instance in"
}
variable key_name {
  description = "The key pair name to use for the instance"
}