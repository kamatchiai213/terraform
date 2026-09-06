resource aws_security_group terraform_security_group {
  name        = "terraform_security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
    }

}