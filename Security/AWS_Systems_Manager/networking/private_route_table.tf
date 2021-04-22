resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.internet_ip
    gateway_id = aws_nat_gateway.NAT_GW.id
  }

  tags = {
    Name = "Private RT"
  }

  depends_on = [aws_vpc.main_vpc, aws_nat_gateway.NAT_GW]
}

resource "aws_route_table_association" "private_rt_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_A.id
  depends_on = [aws_subnet.private_subnet_A, aws_route_table.private_rt]
}