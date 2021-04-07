resource "aws_key_pair" "ssmkey" {
  public_key = file("${path.module}/public_keys/ndomi.pub")
}