/*variable "ssh_keys" {
  default = "ssh_keys.pem"
}*/

variable "aws_ami" {
  type = map
  default = {
    "us-east-1" = "ami-0742b4e673072066f"
    "us-east-2" = "ami-05d72852800cbf29e"
    "us-west-1" = "ami-0577b787189839998"
  }
}

variable "aws_region" {
  default = "us-east-1"
}

variable "i_type" {
  default = "t2.micro"
}