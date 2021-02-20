resource "aws_ebs_volume" "EBS_volume_A" {
  availability_zone = var.availability_zone_B

  size = 10
  type = "gp2"
  tags = {
    Name = "EBS Volume A"
  }

  depends_on = [module.networking.publicSN_B]
}

resource "aws_volume_attachment" "Webapp_server_attach_A" {
  device_name = "/dev/sdc"
  instance_id = aws_instance.Webapp_server_A.id
  volume_id = aws_ebs_volume.EBS_volume_A.id

  depends_on = [aws_ebs_volume.EBS_volume_A, aws_instance.Webapp_server_A]
}