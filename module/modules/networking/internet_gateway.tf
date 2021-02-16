resource "aws_internet_gateway" "IGW_TF" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "IGW_TF"
  }

  depends_on = [aws_vpc.main_vpc]
}