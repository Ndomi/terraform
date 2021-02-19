resource "aws_security_group" "private_A_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "SG from PrivateA RT to NAT GW"

  # Still Needs to be fixed


  tags = {
    Name = "Private A SG"
  }
}

output "privateSG_A" {
  value = aws_security_group.private_A_SG.id
}

resource "aws_security_group_rule" "allow_http_private_A" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.private_A_SG.id
  to_port = 0
  source_security_group_id = aws_security_group.public_SG_A.id
  type = "ingress"

  depends_on = [aws_security_group.public_SG_A, aws_security_group.private_A_SG]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_private_A" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.private_A_SG.id
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]

  depends_on = [aws_security_group.private_A_SG]
}