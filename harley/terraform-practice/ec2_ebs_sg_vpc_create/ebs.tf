resource aws_ebs_volume terraform_ebs {
  availability_zone = var.availability_zone
  size              = var.ebs_size
  tags = {
    Name = "terraform_ebs"
  }
}