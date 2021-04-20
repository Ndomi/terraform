resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Public RT"
  }

  depends_on = [aws_vpc.main_vpc, aws_internet_gateway.IGW]
}

resource "aws_route_table_association" "public_A_RT_ass" {
  route_table_id = aws_route_table.internet.id
  subnet_id      = aws_subnet.public_subnet_A.id
  depends_on     = [aws_subnet.public_subnet_A, aws_route_table.internet]
}

#################################
resource "aws_route_table" "Private_RT_B" {
  vpc_id = aws_vpc.secondary_vpc.id

  route {
    cidr_block = ""
  }
}