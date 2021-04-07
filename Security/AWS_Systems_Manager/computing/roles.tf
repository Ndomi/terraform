resource "aws_iam_role" "test_role" {
  name = "ssm-ec2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action":"sts:AssumeRole",
      "Principal":{
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid":""
    }
  ]
}
EOF

  tags = {
    Name = "SSM-EC2"
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = "ssm-ec2"
  role = aws_iam_role.test_role.id
}

resource "aws_iam_policy_attachment" "attach1" {
  name = "attach1"
  roles = [aws_iam_role.test_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "attach2" {
  name = "attach2"
  roles = [aws_iam_role.test_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}