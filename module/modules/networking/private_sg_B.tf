resource "aws_security_group" "private_B_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "SG from Private RT to NAT GW"

  # Still Needs to be fixed

  tags = {
    Name = "Private B SG"
  }
}

output "privateSG_B" {
  value = aws_security_group.private_B_SG.id
}

resource "aws_security_group_rule" "allow_http_private_B" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.private_B_SG.id
  to_port = 0
  source_security_group_id = aws_security_group.public_SG_B.id
  type = "ingress"

  depends_on = [aws_security_group.public_SG_A, aws_security_group.private_A_SG]
}

resource "aws_security_group_rule" "Allow_all_outgoing_traffic_private_B" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.private_B_SG.id
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]
  type = "egress"

  depends_on = [aws_security_group.private_B_SG]
}