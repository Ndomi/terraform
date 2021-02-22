resource "aws_iam_role" "ec2_role" {
  name = "ec2_roles"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "ec2-role"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name      = "ec2_profile"
  role      = lookup(aws_iam_role.ec2_role.name,terraform.workspace)
}