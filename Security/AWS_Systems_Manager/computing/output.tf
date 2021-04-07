output "ec2-instance" {
  value = aws_instance.ec2.id
}

output "ec2-instance-profile" {
  value = aws_iam_instance_profile.profile.id
}