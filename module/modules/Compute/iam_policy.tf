resource "aws_iam_policy" "s3_policy" {
  name = "s3_policy"
  path = "/"
  description = "s3 policy for Instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3-policy-attachment" {
  policy_arn = aws_iam_policy.s3_policy.arn
  role = aws_iam_role.ec2_role.name
}