variable "ec2_instance_type" {
  type = map
  default = {
    default = "t2.micro"
    stage = "t2.nano"
    prod = "t2.large"
  }
}

variable "ec2_ami" {
  default = ""
}
variable "key" {
  default = ""
}
variable "http_port" {
  default = ""
}
variable "availability_zone_B" {
  default = ""
}
variable "availability_zone_A" {
  default = ""
}