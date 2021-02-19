resource "aws_security_group" "public_SG_A" {
  name        = "EC2-Public_SG A"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG A"


  tags = {
    Name = "Public SG A"
  }
}

resource "aws_security_group_rule" "allow_http_A" {
  type = "ingress"
  from_port = var.http_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  to_port = var.http_port
  source_security_group_id = aws_security_group.alb_SG.id

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_A]
}

resource "aws_security_group_rule" "allow_ssh_A" {
  from_port = var.ssh_port
  protocol = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  cidr_blocks = [var.my_ip_address]
  to_port = var.ssh_port
  type = "ingress"

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_A]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_A" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.public_SG_A.id
  to_port = 0
  cidr_blocks = [var.internet_ip]
  type = "egress"

  depends_on = [aws_security_group.alb_SG, aws_security_group.public_SG_A]
}

output "publicSG_A" {
  value = aws_security_group.public_SG_A.id
}

