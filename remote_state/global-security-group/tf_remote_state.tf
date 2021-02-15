terraform {
  backend "s3" {
    encrypt = true
    bucket = "example.ndomi"
    key = "global-security-group/terrafrom.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}