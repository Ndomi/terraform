resource "aws_s3_bucket" "cloudtrail-access-log-bucket" {
  bucket = "${var.cloudtrail-access-log-bucket}-${var.env}"
  acl = "log-delivery-write"
  force_destroy = true

  tags = {
    Name = "S3 Cloudtrail Access Logs"
  }
}

resource "aws_s3_bucket" "master-cloudtrail-bucket" {
  bucket = "${var.cloudtrail-s3-bucket}-${var.env}"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.cloudtrail-access-log-bucket.id
    target_prefix = "log/"
  }

  tags = {
    Name = "S3 Master Cloudtrail"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.env}"
    },
    {
      "Sid": "AWSCloudTrailWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.env}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "AWSGlueReadLogs",
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.cloudtrail-s3-bucket}-${var.env}/*"
    }
  ]
}
EOF
}

/*resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.master-cloudtrail-bucket.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}*/

resource "aws_glue_catalog_database" "cloudtrail_glue_crawler_db" {
  name = "${var.cloudtrail-glue-catalog-db}-${var.env}"
}
