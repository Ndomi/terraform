resource "aws_key_pair" "inspectorkey" {
  public_key = file("${path.module}/public_key/ndomi.pub")
}

resource "aws_instance" "webserver_a" {
  ami = var.ec2-ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_SG_A.id]
  subnet_id = aws_subnet.public_subnet_A.id
  key_name = aws_key_pair.inspectorkey.key_name
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Public EC2 A"
  }

  depends_on = [aws_vpc.main_vpc, aws_subnet.public_subnet_A]
}

resource "aws_instance" "webserver_b" {
  ami = var.ec2-ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_SG_B.id]
  subnet_id = aws_subnet.public_subnet_B.id
  key_name = aws_key_pair.inspectorkey.key_name
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Public EC2 B"
  }

  depends_on = [aws_vpc.main_vpc, aws_subnet.public_subnet_B]
}