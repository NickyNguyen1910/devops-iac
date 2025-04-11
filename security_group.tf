resource "aws_security_group" "deu1_com_sg_001" {
  name        = "deu1-com-sg-001"
  description = "Allow SSH itself"
  vpc_id      = aws_vpc.deu1-vpc-001.id  

  ingress {
    description = "Allow SSH itself"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self = true
  }


  egress {
    description = "Allow SSH itself"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self = true

  }

  tags = {
    Name = "deu1-com-sg-001"
    Owner = "Hung"
  }
}

resource "aws_security_group" "deu1_bastion_sg_001" {
  name        = "deu1-bastion-sg-001"
  description = "Bastion Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id  

  ingress {
    description = "Allow SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "deu1-bastion-sg-001"
    Owner = "Hung"
  }
}

resource "aws_security_group" "deu1_nat_sg_001" {
  name        = "deu1-nat-sg-001"
  description = "NAT Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id

  egress {
    description = "Traffic to internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description = "Traffic to internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "deu1-nat-sg-001"
    Owner = "Hung"
  }
}


resource "aws_security_group" "deu1_git_sg_001" {
  name        = "deu1-git-sg-001"
  description = "Git Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id

  tags = {
    Name = "deu1-git-sg-001"
    Owner = "Hung"
  }
}


resource "aws_security_group" "deu1_docker_sg_001" {
  name        = "deu1-docker-sg-001"
  description = "Docker Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id

  tags = {
    Name = "deu1-docker-sg-001"
    Owner = "Hung"
  }

}


resource "aws_security_group" "deu1_postgres_sg_001" {
  name        = "deu1-postgres-sg-001"
  description = "Postgres Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id  
  
  tags = {
    Name = "deu1-postgres-sg-001"
    Owner = "Hung"
  }
}

resource "aws_security_group" "deu1_alb_sg_001" {
  name        = "deu1-alb-sg-001"
  description = "Load Balancer Security Group"
  vpc_id      = aws_vpc.deu1-vpc-001.id  

  ingress {
    description = "Allow trafic from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }


  egress {
    description = "Connect to Git"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.deu1_git_sg_001.id]

  }

  tags = {
    Name = "deu1-alb-sg-001"
    Owner = "Hung"
  }
}

resource "aws_security_group_rule" "connect_git_to_nat_80" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_git_sg_001.id
  source_security_group_id = aws_security_group.deu1_nat_sg_001.id
  description = "Connect to NAT"
}

resource "aws_security_group_rule" "connect_git_to_nat_443" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_git_sg_001.id
  source_security_group_id = aws_security_group.deu1_nat_sg_001.id
  description = "Connect to NAT"
}

resource "aws_security_group_rule" "connect_git_to_postgres" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_git_sg_001.id
  source_security_group_id = aws_security_group.deu1_postgres_sg_001.id
  description = "Connect to Postgres"
}

resource "aws_security_group_rule" "connect_docker_to_nat_80" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_docker_sg_001.id
  source_security_group_id = aws_security_group.deu1_nat_sg_001.id
  description = "Connect to NAT"
}

resource "aws_security_group_rule" "connect_docker_to_nat_443" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_docker_sg_001.id
  source_security_group_id = aws_security_group.deu1_nat_sg_001.id
  description = "Connect to NAT"
}

resource "aws_security_group_rule" "connect_docker_to_postgres" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_docker_sg_001.id
  source_security_group_id = aws_security_group.deu1_postgres_sg_001.id
  description = "Connect to Postgres"
}

resource "aws_security_group_rule" "allow_nat_from_git_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_nat_sg_001.id
  source_security_group_id = aws_security_group.deu1_git_sg_001.id
  description = "Allow Git to access NAT"
}

resource "aws_security_group_rule" "allow_nat_from_git_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_nat_sg_001.id
  source_security_group_id = aws_security_group.deu1_git_sg_001.id
  description = "Allow Git to access NAT"
}

resource "aws_security_group_rule" "allow_nat_from_docker_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_nat_sg_001.id
  source_security_group_id = aws_security_group.deu1_docker_sg_001.id
  description = "Allow Docker to access NAT"
}

resource "aws_security_group_rule" "allow_nat_from_docker_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_nat_sg_001.id
  source_security_group_id = aws_security_group.deu1_docker_sg_001.id
  description = "Allow Docker to access NAT"
}

resource "aws_security_group_rule" "allow_postgres_from_git" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_postgres_sg_001.id
  source_security_group_id = aws_security_group.deu1_git_sg_001.id
  description              = "Connect from Git to Postgres"
  
}

resource "aws_security_group_rule" "allow_postgres_from_docker" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_postgres_sg_001.id
  source_security_group_id = aws_security_group.deu1_docker_sg_001.id
  description              = "Connect from Docker to Postgres"
}

resource "aws_security_group_rule" "allow_git_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deu1_git_sg_001.id
  source_security_group_id = aws_security_group.deu1_alb_sg_001.id
  description              = "Connect from ALB to Git"
}