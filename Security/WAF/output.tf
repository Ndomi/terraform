output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "albSG" {
  value = aws_security_group.alb_sg.id
}

output "publicSN_A" {
  value = aws_subnet.public_subnet_A.id
}

output "publicSN_B" {
  value = aws_subnet.public_subnet_B.id
}

output "publicSG_A" {
  value = aws_security_group.public_SG_A.id
}

output "publicSG_B" {
  value = aws_security_group.public_SG_B.id
}