resource "aws_eip" "EIP" {
  vpc = true

  tags = {
    Name = "NAT Gateway EIP"
  }
}