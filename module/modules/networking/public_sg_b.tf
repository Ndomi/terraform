resource "aws_security_group" "public_SG_B" {
  name        = "EC2-Public_SG B"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG B"

  tags = {
    Name = "Public SG B"
  }
}

output "publicSG_B" {
  value = aws_security_group.public_SG_B.id
}

resource "aws_security_group_rule" "Allow_http_B" {
  from_port = var.http_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_B.id
  to_port = var.http_port
  source_security_group_id = aws_security_group.alb_SG.id
  type = "ingress"

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_B]
}

resource "aws_security_group_rule" "Allow_ssh_B" {
  from_port = var.ssh_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_B.id
  to_port = var.ssh_port
  cidr_blocks = [var.internet_ip]
  type = "ingress"

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_B]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_B" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.public_SG_B.id
  to_port = 0
  cidr_blocks = [var.internet_ip]
  type = "egress"

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_B]
}