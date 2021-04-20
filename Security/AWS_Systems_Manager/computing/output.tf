output "bastion_ec2" {
  value = aws_instance.bastion-ec2.id
}

output "private-A-ec2" {
  value = aws_instance.private-A-ec2
}

output "private-B-ec2" {
  value = aws_instance.private-B-ec2
}

output "ec2-instance-profile" {
  value = aws_iam_instance_profile.profile.id
}