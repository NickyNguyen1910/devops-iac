resource "aws_lb" "deu1_git_alb_001" {
  name               = "deu1-git-alb-001"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.deu1_alb_sg_001.id]
  subnets            = [aws_subnet.deu1-private-subnet-a-001.id, aws_subnet.deu1-private-subnet-b-001.id]

  enable_deletion_protection = true

  tags = {
    Owner = "Hung"
  }
}

resource "aws_lb_listener" "deu1_git_alb_001" {
  load_balancer_arn = aws_lb.deu1_git_alb_001.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.deu1-gitgr-001.arn
  }
}