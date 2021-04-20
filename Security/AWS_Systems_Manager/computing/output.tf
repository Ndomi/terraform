output "bastion_ec2" {
  value = aws_instance.bastion-ec2.id
}

output "private-ec2" {
  value = aws_instance.private-ec2.id
}

output "ec2-instance-profile" {
  value = aws_iam_instance_profile.profile.id
}