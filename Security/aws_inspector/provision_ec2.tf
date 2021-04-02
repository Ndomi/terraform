resource "aws_key_pair" "inspectorkey" {
  public_key = file("${path.module}/public_keys/ndomi.pub")
}

resource "aws_instance" "inspector-instance" {
  ami = lookup(var.aws_ami, var.aws_region)
  instance_type = var.i_type
  key_name = aws_key_pair.inspectorkey.key_name

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = aws_instance.inspector-instance.public_ip
      timeout = "2m"
    }
    inline = [
      "wget https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install -P /tmp/",
      "sudo bash /tmp/install"
    ]
  }

  tags = {
    Name = "InspectorInstance"
  }
}

resource "aws_inspector_resource_group" "aws_inspector" {
  tags = {
    Name = aws_instance.inspector-instance.tags.Name
  }
}

resource "aws_inspector_assessment_target" "My_EC2" {
  name = "inspector-instance-assessment"
  resource_group_arn = aws_inspector_resource_group.aws_inspector.arn
}

resource "aws_inspector_assessment_template" "inspector_template" {
  duration = 3600
  name = "inspector template"
  target_arn = aws_inspector_assessment_target.My_EC2.arn
  rules_package_arns = [
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-rExsr2X8",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-R01qwB5Q",
  ]
}