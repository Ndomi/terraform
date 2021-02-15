resource "aws_security_group" "webserver_sg" {
  ingress {
    from_port = var.http_port
    protocol = "tcp"
    to_port = var.http_port
    cidr_blocks = [var.my_system]
  }

  ingress {
    from_port = var.ssh_port
    protocol = "tcp"
    to_port = var.ssh_port
    cidr_blocks = [var.my_system]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "terraform_remote_state" "global_sg" {
  backend = "s3"
  config = {
    bucket = "example.ndomi"
    key = "global-security-group/terrafrom.tfstate"
    region = "us-east-1"
  }
}
