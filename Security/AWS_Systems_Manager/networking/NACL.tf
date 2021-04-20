/*
resource "aws_network_acl" "test" {
  vpc_id = aws_vpc.main_vpc.id
}
*/

resource "aws_network_acl_rule" "allow_ingress_icmp_test" {
  network_acl_id = "acl-0c860bc76e0646b80"
  rule_number = 10
  egress = false
  protocol = "icmp"
  rule_action = "deny"
  cidr_block = var.internet_ip
  from_port = -1
  to_port = -1
  icmp_type = -1
  icmp_code = -1
}

resource "aws_network_acl_rule" "allow_egress_icmp_test" {
  network_acl_id = "acl-0c860bc76e0646b80"
  rule_number = 10
  egress = true
  protocol = "icmp"
  rule_action = "deny"
  cidr_block = var.internet_ip
  from_port = -1
  to_port = -1
  icmp_type = -1
  icmp_code = -1
}

