variable "ec2_instance_type" {
  type = map
  default = {
    default = "t2.micro"
    stage = "t2.nano"
    prod = "t2.large"
  }
}