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