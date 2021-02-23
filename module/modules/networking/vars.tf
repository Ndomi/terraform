variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_A" {
  default = "10.0.1.0/28"
}

variable "public_subnet_cidr_B" {
  default = "10.0.2.0/28"
}

variable "private_subnet_cidr_A" {
  default = "10.0.3.0/24"
}

variable "private_subnet_cidr_B" {
  default = "10.0.4.0/24"
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

variable "availability_zone_A" {
  default = "us-east-1a"
}

variable "availability_zone_B" {
  default = "us-east-1b"
}

variable "public_subnet_names_A" {
  default = "public_subnet_1a"
}

variable "private_subnet_names_B" {
  default = "public_subnet_1b"
}
