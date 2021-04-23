resource "aws_iam_role" "ec2_role" {
  name = "ec2_roles"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "s3-endpoint-role"
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id = aws_vpc.main_vpc.id
  vpc_endpoint_type = "Gateway"

/*  policy = <<EOF
{
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
EOF*/
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  route_table_id = aws_route_table.private_rt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}