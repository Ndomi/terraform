variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "http_port" {
  default = 80
}

variable "internet_ip" {
  default = "0.0.0.0/0"
}

variable "ssh_port" {
  default = 22
}

variable "my_ip_address" {
  default = "xxx.xxx.xxx.xxx/32"
}

variable "public_subnet_cidr_A" {
  default = "10.0.1.0/28"
}

variable "public_subnet_cidr_B" {
  default = "10.0.2.0/28"
}

variable "availability_zone_A" {
  default = "us-east-1a"
}

variable "availability_zone_B" {
  default = "us-east-1b"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2-ami" {
  default = "ami-047a51fa27710816e"
}
