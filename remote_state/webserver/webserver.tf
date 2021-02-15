resource "aws_instance" "hello-world" {
  ami = var.ami
  instance_type = var.instance
  vpc_security_group_ids = [aws_security_group.webserver_sg.id, data.terraform_remote_state.global_sg.outputs.global_sg_id]
  key_name = "New_Key"

  tags = {
    Name = "Hello World"
  }

  user_data = <<-EOF
    apt-get update
    apt-get install httpd -y
    echo "Hello World" > /var/www/html/index.html
    instance_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
    echo $instance_ip >> /var/www/html/index.html
  EOF
}