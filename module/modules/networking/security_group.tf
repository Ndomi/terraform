resource "aws_security_group" "public_SG_A" {
  name        = "EC2-Public_SG A"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG A"

  ingress {
    from_port = var.http_port
    protocol = "tcp"
    to_port = var.http_port
    security_groups = [aws_security_group.alb_SG.id]
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
    Name = "Public SG A"
  }
}

output "publicSG_A" {
  value = aws_security_group.public_SG_A.id
}

resource "aws_security_group" "public_SG_B" {
  name        = "EC2-Public_SG B"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG B"

  ingress {
    from_port = var.http_port
    protocol = "tcp"
    to_port = var.http_port
    security_groups = [aws_security_group.alb_SG.id]
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
    Name = "Public SG B"
  }
}

output "publicSG_B" {
  value = aws_security_group.public_SG_B.id
}

resource "aws_security_group" "alb_SG" {
  name = "ALB-SG"
  vpc_id = aws_vpc.main_vpc.id
  description = "ALB Security Group"

  ingress {
    from_port = var.http_port
    protocol = "tcp"
    to_port = var.http_port
    cidr_blocks = [var.internet_ip]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [var.internet_ip]
  }

  tags = {
    Name = "ALB SG"
  }
}

output "albSG" {
  value = aws_security_group.alb_SG.id
}

resource "aws_security_group" "private_A_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "SG from PrivateA RT to NAT GW"

# Still Needs to be fixed

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    security_groups = [aws_security_group.public_SG_A.id]
  }

/*  ingress {
    from_port = var.ssh_port
    protocol = "tcp"
    to_port = var.ssh_port
    security_groups = [aws_security_group.public_SG_A.id]
  }*/

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private A SG"
  }
}

output "privateSG_A" {
  value = aws_security_group.private_A_SG.id
}

resource "aws_security_group" "private_B_SG" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "SG from Private RT to NAT GW"

  # Still Needs to be fixed
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    security_groups = [aws_security_group.public_SG_B.id]
  }

/*  ingress {
    from_port = var.ssh_port
    protocol = "tcp"
    to_port = var.ssh_port
    security_groups = [aws_security_group.public_SG_A.id]
  }*/

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private B SG"
  }
}

output "privateSG_B" {
  value = aws_security_group.private_B_SG.id
}
