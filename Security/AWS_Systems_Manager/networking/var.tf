variable "internet_ip" {
  default = "0.0.0.0/0"
}

variable "my_ip_address" {
  default = "102.65.85.45/32"
}

variable "public_subnet_cidr_A" {
  default = "10.0.1.0/28"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zone_A" {
  default = "us-east-1a"
}

variable "http_port" {
  default = 80
}

variable "ssh_port" {
  default = 22
}
