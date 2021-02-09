resource "aws_instance" "ec2_example" {
  ami = "ami-047a51fa27710816e"
  instance_type = "t2.micro"
  key_name = "New_Key"
}