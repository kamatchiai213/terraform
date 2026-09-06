resource aws_vpc terraform_vpc {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "terraform_vpc"
    }
}

resource aws_subnet terraform_subnet {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "terraform_pubsubnet"
  }
}

resource aws_internet_gateway terraform_igw {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "terraform_igw"
  }
}

resource aws_route_table terraform_route_table {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
    }
    tags = {
        Name = "terraform_route_table"
    }
}
