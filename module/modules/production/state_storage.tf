/*resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "example.ndomi.state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "s3 Remote Terraform State Stote"
  }
}*/

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "example.ndomi.state"
    //    dynamodb_table = "dynamodb-terraform-state-lock"
    region = "us-east-1"
    key    = "terraform.tfstate"

  }
}

#####  Enable the below code to prevent multiple user to edit the state ######
##### Charges apply #####

/*resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  hash_key = "LockID"
  name = "terraform-state-lock-dynamo"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = " DynamoDB Terraform State Lock Table"
  }
}*/
