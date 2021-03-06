module "cloudwatch" {
  source = "../CloudWatch_Log"
}

resource "aws_iam_role" "test_role" {
  name               = "ssm-ec2"
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
  name       = "attach1"
  roles      = [aws_iam_role.test_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "attach2" {
  name       = "attach2"
  roles      = [aws_iam_role.test_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_policy_attachment" "attach3" {
  name       = "attach3"
  policy_arn = module.cloudwatch.cloudwatch_log
  roles      = [aws_iam_role.test_role.id]
}

######## For s3 Endpoint ########

resource "aws_iam_role" "test_role_2" {
  name               = "s3-endpoint"
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
    Name = "S3-endpoint"
  }
}

resource "aws_iam_instance_profile" "s3-endpoint-profile" {
  name = "s3-endpoint-profile"
  role = aws_iam_role.test_role_2.name
}

resource "aws_iam_role_policy" "s3-endpoint" {
  name = "s3-endpoint"
  role = aws_iam_role.test_role_2.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}