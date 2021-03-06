resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.IGW_TF.id
  }

  tags = {
    Name = "Public RT"
  }

  depends_on = [aws_vpc.main_vpc, aws_internet_gateway.IGW_TF]
}

resource "aws_route_table_association" "public_A_RT_association" {
  route_table_id = aws_route_table.internet.id
  subnet_id      = aws_subnet.public_subnet_A.id
  depends_on     = [aws_subnet.public_subnet_A, aws_route_table.internet]
}

resource "aws_route_table_association" "public_B_RT_association" {
  route_table_id = aws_route_table.internet.id
  subnet_id      = aws_subnet.public_subnet_B.id
  depends_on     = [aws_subnet.public_subnet_B, aws_route_table.internet]
}