resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.public_subnet_A.id

  tags = {
    Name = "NAT Gateway"
  }

  depends_on = [aws_eip.EIP, aws_subnet.public_subnet_A]
}