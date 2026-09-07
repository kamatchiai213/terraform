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

variable "cidr_blocks" {
  description = "The CIDR block for the sg route"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "vpc_cidr_blocks" {
  description = "The CIDR block for the VPC"
  type        = string
}

# NEW — this is the workspace safety net.
# Each .tfvars file declares which workspace it is meant for.
# If you forget to `terraform workspace select` before applying,
# this mismatch stops the apply instead of silently building
# dev-shaped infra while sitting in the prod workspace.
variable "expected_workspace" {
  description = "The workspace this .tfvars file is meant to be applied in (dev/prod)"
  type        = string
}
