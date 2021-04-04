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

resource "aws_alb_target_group_attachment" "target_group_alb_a" {
  target_group_arn = aws_alb_target_group.alb_front.arn
  target_id = aws_instance.webserver_a.id
  port = var.http_port

  depends_on = [aws_security_group.public_SG_A, aws_alb_target_group.alb_front]
}

resource "aws_alb_target_group_attachment" "target_group_alb_b" {
  target_group_arn = aws_alb_target_group.alb_front.arn
  target_id = aws_instance.webserver_b.id
  port = var.http_port

  depends_on = [aws_security_group.public_SG_B, aws_alb_target_group.alb_front]
}

resource "aws_lb_listener" "listener_A" {
  load_balancer_arn = aws_alb.ALB.arn
  port = var.http_port
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_front.arn
  }

  depends_on = [aws_alb_target_group.alb_front, aws_alb.ALB]
}