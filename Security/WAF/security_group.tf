resource "aws_security_group" "public_SG_A" {
  name = "Public_SG_A"
  vpc_id = aws_vpc.main_vpc.id
  description = "Public SG A"

  tags = {
    Name = "Public SG A"
  }
}

resource "aws_security_group_rule" "allow_http_A" {
  from_port = var.http_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  source_security_group_id = aws_security_group.alb_sg.id
  to_port = var.http_port
  type = "ingress"

  depends_on = [aws_security_group.alb_sg, aws_security_group.public_SG_A]
}

resource "aws_security_group_rule" "allow_ssh_A" {
  from_port = var.ssh_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  to_port = var.ssh_port
  type = "ingress"
  cidr_blocks = [var.my_ip_address]

  depends_on = [aws_security_group.alb_sg, aws_security_group.public_SG_A]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_A" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.public_SG_A.id
  to_port = 0
  type = "egress"
  cidr_blocks = [var.internet_ip]
}

#################### PUBLIC SUBNET B ####################
resource "aws_security_group" "public_SG_B" {
  name = "Public_SG_B"
  vpc_id = aws_vpc.main_vpc.id
  description = "Public SG B"

  tags = {
    Name = "Public SG B"
  }
}

resource "aws_security_group_rule" "allow_http_B" {
  from_port = var.http_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_B.id
  source_security_group_id = aws_security_group.alb_sg.id
  to_port = var.http_port
  type = "ingress"

  depends_on = [aws_security_group.alb_sg, aws_security_group.public_SG_B]
}

resource "aws_security_group_rule" "allow_ssh_B" {
  from_port = var.ssh_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_B.id
  to_port = var.ssh_port
  type = "ingress"
  cidr_blocks = [var.my_ip_address]

  depends_on = [aws_security_group.alb_sg, aws_security_group.public_SG_B]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_B" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.public_SG_B.id
  to_port = 0
  type = "egress"
  cidr_blocks = [var.internet_ip]
}