resource "aws_alb" "ALB" {
  name = "My-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = [aws_subnet.public_subnet_A.id, aws_subnet.public_subnet_B.id]

}

resource "aws_alb_target_group" "alb_front" {
  name = "alb-front"
  vpc_id = aws_vpc.main_vpc.id
  port = var.http_port
  protocol = "HTTP"
  health_check {
    path = "/"
    port = var.http_port
    protocol = "HTTP"
    healthy_threshold = 10
    unhealthy_threshold = 5
    interval = 10
    timeout = 8
    matcher = "200"
  }

  tags = {
    Name = "front_http"
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_alb_target_group" "alb_front2" {
  name = "alb-front2"
  vpc_id = aws_vpc.main_vpc.id
  port = var.http_port
  protocol = "HTTP"
  health_check {
    path = "/"
    healthy_threshold = 10
    unhealthy_threshold = 5
    interval = 10
    timeout = 8
    matcher = "200"
  }
  tags = {
    Name = "front_http2"
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_autoscaling_attachment" "asg_attachment_1" {
  autoscaling_group_name = aws_autoscaling_group.ASG_1.id
  alb_target_group_arn = aws_alb_target_group.alb_front.arn
}

resource "aws_autoscaling_attachment" "asg_attachment_2" {
  autoscaling_group_name = aws_autoscaling_group.ASG_2.id
  alb_target_group_arn = aws_alb_target_group.alb_front2.arn
}

resource "aws_lb_listener" "listener_A" {
  load_balancer_arn = aws_alb.ALB.arn
  port = var.http_port
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.alb_front.arn
        weight = 80
      }
      target_group {
        arn = aws_alb_target_group.alb_front2.arn
        weight = 20
      }
    }
  }
  depends_on = [aws_alb_target_group.alb_front, aws_alb.ALB]
}