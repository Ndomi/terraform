module "networking" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/networking?ref=v0.0.6"
}

resource "aws_instance" "Jumpbox_A" {

  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.networking.publicSG_A]
  subnet_id = module.networking.publicSN_A
  key_name = var.key

  tags = {
    Name = "Public EC2 A"
  }

  depends_on = [module.networking.vpc_id, module.networking.publicSN_A]
}

resource "aws_instance" "Jumpbox_B" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.networking.publicSG_B]
  subnet_id = module.networking.publicSN_A
  key_name = var.key

  tags = {
    Name = "Public EC2 B"
  }

  depends_on = [module.networking.vpc_id, module.networking.publicSN_B]

}

resource "aws_instance" "Webapp_server_A" {

  ami = var.ec2_ami
  instance_type =var.ec2_instance_type
  vpc_security_group_ids = [module.networking.publicSG_A]
  subnet_id = module.networking.publicSN_B
  key_name = var.key

  tags = {
    Name = "Private EC2 A"
  }

  user_data = file("${path.module}/user_data.sh")

  depends_on = [module.networking.vpc_id, module.networking.publicSN_B]
}

resource "aws_instance" "Webapp_server_B" {

  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.networking.publicSG_B]
  subnet_id = module.networking.publicSN_B
  key_name = var.key

  tags = {
    Name = "Private EC2 B"
  }

  user_data = file("${path.module}/user_data.sh")

  depends_on = [module.networking.vpc_id, module.networking.publicSN_B]
}


        #### Creating a Application Load Balancer (ALB) ####
resource "aws_alb" "webapp_loadbalancer" {
  load_balancer_type = "application"
  name = "web-ALB"
  internal = false
  security_groups = [module.networking.albSG]
  subnets = [module.networking.publicSN_A, module.networking.publicSN_B]

  tags = {
    Name = "web_app_ALB"
  }

  depends_on = [module.networking.publicSN_A, module.networking.publicSN_B, module.networking.publicSG_A, module.networking.publicSG_B]
}

resource "aws_alb_target_group" "alb_front_http" {
  name = "alb-front-http"
  vpc_id = module.networking.vpc_id
  port = var.http_port
  protocol = "HTTP"
  health_check {
    path = "/"
    port = "80"
    protocol = "HTTP"
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 5
    timeout = 4
    matcher = "200"
  }

  tags = {
    Name = "alb_front_http"
  }

  depends_on = [module.networking.vpc_id]
}

resource "aws_alb_target_group_attachment" "targetgroup_alb_B" {
  target_group_arn = aws_alb_target_group.alb_front_http.arn
  target_id = aws_instance.Webapp_server_A.id
  port = var.http_port

  depends_on = [module.networking.publicSG_A, aws_alb_target_group.alb_front_http]
}

resource "aws_alb_target_group_attachment" "targetgroup_alb_A" {
  target_group_arn = aws_alb_target_group.alb_front_http.arn
  target_id = aws_instance.Webapp_server_B.id
  port = var.http_port

  depends_on = [module.networking.publicSN_B, aws_alb_target_group.alb_front_http]
}

resource "aws_lb_listener" "listener_A" {
  load_balancer_arn = aws_alb.webapp_loadbalancer.arn
  port = var.http_port
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_front_http.arn
  }

  depends_on = [aws_alb_target_group.alb_front_http, aws_alb.webapp_loadbalancer]
}

        ####  How to Add Security Group Rules, without editing the Module ####
/*
resource "aws_security_group_rule" "allow_test" {
  from_port = 10000
  protocol = "tcp"
  security_group_id = module.networking.publicSG_A
  to_port = 10000
  type = "ingress"
  cidr_blocks = ["xxx.xxx.xxx.xxx/xx"]
}*/
