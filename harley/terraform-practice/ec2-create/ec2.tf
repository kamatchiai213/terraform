
resource "aws_instance" "terraform_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = var.tag_name
  }

}








