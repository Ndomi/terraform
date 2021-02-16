resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.public_az
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

output "publicSN" {
  value = aws_subnet.public_subnet.id
}