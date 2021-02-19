resource "aws_subnet" "private_subnet_A" {

  cidr_block              = var.private_subnet_cidr_A
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.availability_zone_A
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet A"
  }
}

output "privateSN_A" {
  value = aws_subnet.private_subnet_A.id
}

resource "aws_subnet" "private_subnet_B" {

  cidr_block              = var.private_subnet_cidr_B
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.availability_zone_B
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet B"
  }
}

output "privateSN_B" {
  value = aws_subnet.private_subnet_B.id
}