resource "aws_iam_role" "flow_logs_role" {
  name               = "flow_logs_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow_logs_policy" {
  name   = "flow_logs_policy"
  role   = aws_iam_role.flow_logs_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "log_groups" {
  name              = "log_groups1"
  retention_in_days = 60
}

resource "aws_flow_log" "flow_logs" {
  vpc_id          = aws_vpc.main_vpc.id
  traffic_type    = "ALL"
  log_destination = aws_cloudwatch_log_group.log_groups.arn

  iam_role_arn = aws_iam_role.flow_logs_role.arn

  depends_on = [aws_cloudwatch_log_group.log_groups]

}