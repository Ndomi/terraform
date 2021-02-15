resource "aws_security_group" "global_sg" {
  name = "allow_db"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port = 1521
    protocol = "tcp"
    to_port = 1521
    cidr_blocks = ["10.145.8.0/25"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}