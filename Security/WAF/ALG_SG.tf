resource "aws_security_group" "alb_sg" {
  name = "ALB_SG"
  vpc_id = aws_vpc.main_vpc.id
  description = "ALB Security Group"

  tags = {
    Name = "ALB SG"
  }
}

resource "aws_security_group_rule" "Allow_http_ALB" {
  from_port = var.http_port
  protocol = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  to_port = var.http_port
  type = "ingress"
  cidr_blocks = [var.internet_ip]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_ALB" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.alb_sg.id
  to_port = 0
  type = "egress"
  cidr_blocks = [var.internet_ip]
  depends_on = [aws_security_group.alb_sg]
}