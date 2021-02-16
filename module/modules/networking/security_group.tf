resource "aws_security_group" "public_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG"

  ingress {
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    protocol    = "tcp"
    to_port     = var.ssh_port
    cidr_blocks = [var.my_ip_address]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_ip]
  }

  tags = {
    Name = "Public SG"
  }
}

output "publicSG" {
  value = aws_security_group.public_SG.id
}

resource "aws_security_group" "private_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "SG from Private RT to NAT GW"


  ingress {
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
    security_groups = [aws_security_group.public_SG.id]
  }

  ingress {
    from_port = var.ssh_port
    protocol = "tcp"
    to_port = var.ssh_port
    security_groups = [aws_security_group.public_SG.id]
  }

  tags = {
    Name = "Private SG"
  }
}

output "privateSG" {
  value = aws_security_group.private_SG.id
}