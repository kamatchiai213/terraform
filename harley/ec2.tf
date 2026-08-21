resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "terraform_subnet"
  }
  availability_zone = "us-west-2a"
}

resource "aws_internet_gateway" "terraform_internet_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "terraform_internet_gateway"
  }
}
# resource "aws_route_table" "terraform_route_table" {
#   vpc_id = aws_vpc.terraform_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.terraform_internet_gateway.id
#   }

#   tags = {
#     Name = "terraform_route_table"
#   }
# }

resource "aws_default_route_table" "terraform_default_route_table" {
  default_route_table_id = aws_vpc.terraform_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_internet_gateway.id
  }

  tags = {
    Name = "terraform_default_route_table"
  }
}

resource "aws_route_table_association" "terraform_route_table_association" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_default_route_table.terraform_default_route_table.id
}

resource "aws_security_group" "terraform_security_group" {
  name        = "terraform_security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
    
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "webserver" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "webserver"
    vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
    subnet_id = aws_subnet.terraform_subnet.id


    tags = {
        Name = var.tags_name
        env = "default"
    }
    availability_zone = "us-west-2a"
    
    
}

resource "aws_ebs_volume" "webserver_volume" {
    availability_zone = "us-west-2a"
    size              = 2
    type              = "gp3"
    tags = {
        Name = "webserver-volume"
    }
}

resource "aws_volume_attachment" "webserver_volume_attachment" {
    device_name = "/dev/sdh"
    volume_id   = aws_ebs_volume.webserver_volume.id
    instance_id = aws_instance.webserver.id
}


