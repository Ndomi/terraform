variable "region" {
  default = "us-east-1"
}

variable "http_port" {
  default = 80
}

variable "ssh_port" {
  default = 22
}

variable "ip_address" {
  default = "102.222.182.45/32"
}

variable "ami" {
  default = "ami-047a51fa27710816e"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key" {
  default = "New_Key"
}