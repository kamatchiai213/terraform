resource aws_instance "terraform_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
  subnet_id = aws_subnet.terraform_subnet.id
  key_name = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = var.tag_name
  }

}