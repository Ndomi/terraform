resource "aws_iam_group" "operations" {
  name = var.ops
}

resource "aws_iam_group" "developers" {
  name = var.dev
}

resource "aws_iam_group" "testers" {
  name = var.testing
}

resource "aws_iam_group" "devops" {
  name = var.devops
}