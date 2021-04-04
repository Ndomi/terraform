/*
resource "aws_s3_bucket" "S3Bucket" {
  bucket = "example.ndomi.alb"
  acl = "public-read"

  versioning {
    enabled = true
  }

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::example.ndomi.alb",
                "arn:aws:s3:::example.ndomi.alb*/
/*"
            ]
        }
    ]
}
EOF

  tags = {
    Name = "My bucket"
  }
}
*/

/*
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.S3Bucket.id

  block_public_acls = true
  //block_public_policy = true
}*/
