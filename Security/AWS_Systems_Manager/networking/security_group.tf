resource "aws_security_group" "public_SG_A" {
  name        = "Public_SG_A"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Public SG A"

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

resource "aws_security_group" "private_SG_A" {
  name        = "Private_SG_A"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Private SG A"

  ingress {
    from_port       = var.ssh_port
    protocol        = "tcp"
    to_port         = var.ssh_port
    security_groups = [aws_security_group.public_SG_A.id]
    description     = "Allow ssh from ${aws_security_group.public_SG_A.name}"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_ip]
  }

  tags = {
    Name = "Private SG A"
  }
}

resource "aws_security_group" "private_SG_B" {
  name        = "Private_SG_B"
  vpc_id      = aws_vpc.secondary_vpc.id
  description = "Private SG B"

  ingress {
    from_port       = var.ssh_port
    protocol        = "tcp"
    to_port         = var.ssh_port
    security_groups = [aws_security_group.private_SG_A.id]
    description     = "Allow ssh from ${aws_security_group.private_SG_A.name} and ${aws_security_group.public_SG_A.name}"
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }

  tags = {
    Name = "Private SG B"
  }
}

/*resource "aws_security_group_rule" "allow_http_A" {
  from_port         = var.http_port
  protocol          = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  to_port           = var.http_port
  cidr_blocks       = [var.my_ip_address]
  type              = "ingress"

  depends_on = [aws_security_group.public_SG_A]
}*/

/*resource "aws_security_group_rule" "allow_ssh_A" {
  from_port         = var.ssh_port
  protocol          = "tcp"
  security_group_id = aws_security_group.public_SG_A.id
  to_port           = var.ssh_port
  type              = "ingress"
  cidr_blocks       = [var.my_ip_address]

  depends_on = [aws_security_group.public_SG_A]
}*/

/*
resource "aws_security_group_rule" "Allow_all_outgoing_traffic_A" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.public_SG_A.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = [var.internet_ip]
}*/
