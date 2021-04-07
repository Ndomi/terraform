resource "aws_subnet" "public_subnet_A" {
  cidr_block = var.public_subnet_cidr_A
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = var.availability_zone_A
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet A"
  }
}