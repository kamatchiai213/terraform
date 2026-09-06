resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_blocks
}


resource "aws_subnet" "terraform_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_blocks
  availability_zone = var.availability_zone
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_blocks
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.route_table.id
}

