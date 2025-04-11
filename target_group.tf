resource "aws_lb_target_group" "deu1-gitgr-001" {
  name     = "deu1-gitgr-001"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.deu1-vpc-001.id 


  health_check {
    path                = "/test"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.deu1-gitgr-001.arn 
  target_id        = aws_instance.git.id
  port             = 80
}
