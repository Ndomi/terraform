resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Sid": "",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Name = "ec2-role"
  }
}

resource "aws_iam_policy" "developers" {
  name = "developers"
  description = "This is the access policy for developers"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1613552401287",
      "Action": [
        "s3:Get*",
        "s3:List*",
        "s3:Put*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::example.ndomi"
    }
  ]
}
EOF
}

/*
resource "aws_iam_role_policy_attachment" "s3-plo-attach" {
  policy_arn = aws_iam_policy.developers.arn
  role = aws_iam_role.ec2_role.name

}*/
