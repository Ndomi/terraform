resource "aws_instance" "ec2_example" {
  ami = "ami-047a51fa27710816e"
  instance_type = "t2.micro"
//  key_name = "New_Key"

  tags = {
    Name = "Dev Ec2"
  }
}

resource "aws_key_pair" "ec2_example" {
  key_name   = "ndomi"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC78/zLLdvuXtt3hUEVdN5H7cTxGGYTXqAB3KCgU6aeTZl81VXrkYhRFerbvn9JwcTPrdhBIv99sgyfNH/oy57GCM/Ep+fRA4gvxqihsgeH/X51KIoFhzZ4vDIkFG2XviJ0WUox4T7JZMY5Z5QPBGr2RyZcGQY/NCa5drZZm1d7EkYljrgDE11XdjHQHOnbKpXfxXkrdZmGYFyS2kCAq+JS5AJG+/VODRjvWha7MgpTnAcrKcRjgUIxYmfR4N4oXnNqgroIAAWgSM9tpLaobVlo4IvrWB4hJPcZXNfk3cM4PSndPD1xi26Ea1iunMFoYwNKQk36VCQMvMm7vQlqbeoiq2lA1YVC7tC4mk0lVHKtDNR8FyIWbJ0iSOM7ZZ22Kgl38nsYEXYHevJ734A5SRC66ZHY0fNs3vx5pGYlIHQmelrSINqVSX9FI6Jq3lyfi1taxySZbwasudmA+vCJGpUETbyq6CrLhO9p4NSkfX9uHwssopK/92A5gPiCzZso0o0= ndomi@terminator"
}