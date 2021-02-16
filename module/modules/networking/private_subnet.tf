resource "aws_subnet" "private_subnet" {
  cidr_block              = var.private_subnet_cidr
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.private_az
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet"
  }
}

output "privateSN" {
  value = aws_subnet.private_subnet.id
}