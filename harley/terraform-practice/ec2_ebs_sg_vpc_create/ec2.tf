resource aws_instance terraform_ec2 {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
  subnet_id     = aws_subnet.terraform_subnet.id
  availability_zone = var.availability_zone

  tags = {
    Name = var.tag_name
    env  = "default"
  }
}