resource "aws_ebs_volume" "EBS_volume_A" {
  availability_zone = module.networking.publicSN_B

  size = 10
  type = "gp2"
  tags = {
    Name = ""
  }
}

resource "aws_volume_attachment" "Webapp_server_attach_A" {
  device_name = "/dev/sdc"
  instance_id = aws_instance.Webapp_server_A.id
  volume_id = aws_ebs_volume.EBS_volume_A.id
}