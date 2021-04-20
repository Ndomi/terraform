data "aws_caller_identity" "current" {}

resource "aws_vpc_peering_connection" "primary_secondary" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  vpc_id        = aws_vpc.main_vpc.id
  peer_vpc_id   = aws_vpc.secondary_vpc.id

  # Flags that the peering connection should be automatically confirmed. This
  # only works if both VPCs are owned by the same account.
  auto_accept = true
}

resource "aws_route" "primary-to-secondary" {
  # ID of VPC 1 main route table.
  route_table_id = aws_vpc.main_vpc.main_route_table_id

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = aws_vpc.secondary_vpc.cidr_block

  # ID of VPC peering connection.
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_secondary.id
}

resource "aws_route" "secondary-to-primary" {
  # ID of VPC 2 main route table.
  route_table_id = aws_vpc.secondary_vpc.main_route_table_id

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = aws_vpc.main_vpc.cidr_block

  # ID of VPC peering connection.
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_secondary.id
}