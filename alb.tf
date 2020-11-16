data "aws_subnet_ids" "all_public" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "*public*"
  }
}

resource "aws_lb_target_group" "test-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.test_vpc.id
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.test_sg.id]
  subnets            = data.aws_subnet_ids.all_public.ids

  enable_deletion_protection = true

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "test-alb-listner" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-target-group.arn
  }
}