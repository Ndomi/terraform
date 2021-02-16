variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/28"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "internet_ip" {
  default = "0.0.0.0/0"
}

variable "http_port" {
  default = 80
}

variable "ssh_port" {
  default = 22
}

variable "my_ip_address" {
  default = "102.222.182.45/32"
}

variable "public_az" {
  default = "us-east-1a"
}

variable "private_az" {
  default = "us-east-1b"
}