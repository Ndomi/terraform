variable "ec2_instance_type" {
  type = map
  default = {
    default = "t2.micro"
    stage = "t2.nano"
    prod = "t2.large"
  }
}

variable "ec2_ami" {
  default = "ami-047a51fa27710816e"
}

/*variable "key" {
  default = "New_Key"
}*/

variable "http_port" {
  default = 80
}

variable "availability_zone_B" {
  default = "us-east-1b"
}

variable "availability_zone_A" {
  default = "us-east-1a"
}