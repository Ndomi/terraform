output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "publicSN_A" {
  value = aws_subnet.public_subnet_A.id
}

output "publicSG_A" {
  value = aws_security_group.public_SG_A.id
}

output "privateSG_A" {
  value = aws_security_group.private_SG_A.id
}

output "privateSG_B" {
  value = aws_security_group.private_SG_B.id
}

output "privateSN_A" {
  value = aws_subnet.private_subnet_A.id
}

output "privateSN_B" {
  value = aws_subnet.private_subnet_b.id
}

######## Output for VPC Peering ########

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}