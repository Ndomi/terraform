resource "aws_vpc" "main_vpc" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true

  tags = {
    Name = "Custom VPC"
  }
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}