resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Primary VPC"
  }
}

resource "aws_vpc" "secondary_vpc" {
  cidr_block = var.sec_vpc_cidr

  tags = {
    Name = "Secondary VPC"
  }
}