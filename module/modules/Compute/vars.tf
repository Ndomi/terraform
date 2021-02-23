variable "ec2_instance_type" {
  type = map
  default = {
    default = "t2.micro"
    stage = "t2.nano"
    prod = "t2.large"
  }
}

variable "ec2_ami" {}
variable "key" {}
variable "http_port" {}
variable "availability_zone_B" {}
variable "availability_zone_A" {}