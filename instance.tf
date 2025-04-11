resource "aws_instance" "bastion" {
  ami           = "ami-00c257e12d6828491" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.deu1-public-subnet-a-001.id  
  key_name      = "deu1-testkey-001"  
  vpc_security_group_ids = [
    aws_security_group.deu1_bastion_sg_001.id,
    aws_security_group.deu1_com_sg_001.id
    ]
  associate_public_ip_address = true

  tags = {
    Name = "deu1-bastion-001"
    Owner = "Hung"
  }
}

resource "aws_instance" "nat_instance" {
  ami           = "ami-027951e78de46a00e" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.deu1-public-subnet-a-001.id  
  key_name      = "deu1-testkey-001"  
  vpc_security_group_ids = [
    aws_security_group.deu1_nat_sg_001.id,
    aws_security_group.deu1_com_sg_001.id
    ]
  associate_public_ip_address = true
  
  tags = {
    Name = "deu1-nat-instance-001"
    Owner = "Hung"
  }
}

resource "aws_instance" "git" {
  ami           = "ami-00c257e12d6828491" 
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.deu1-private-subnet-a-001.id  
  key_name      = "deu1-testkey-001"
  vpc_security_group_ids = [
    aws_security_group.deu1_git_sg_001.id,
    aws_security_group.deu1_com_sg_001.id
    ]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "deu1-git-001"
    Owner = "Hung"
  }
}

resource "aws_instance" "docker" {
  ami           = "ami-00c257e12d6828491" 
  instance_type = "t2.small"
  subnet_id     = aws_subnet.deu1-private-subnet-a-001.id  
  key_name      = "deu1-testkey-001"
  vpc_security_group_ids = [
    aws_security_group.deu1_docker_sg_001.id,
    aws_security_group.deu1_com_sg_001.id
    ]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "deu1-docker-001"
    Owner = "Hung"
  }
}

resource "aws_instance" "postgres" {
  ami           = "ami-00c257e12d6828491" 
  instance_type = "t2.small"
  subnet_id     = aws_subnet.deu1-data-subnet-a-001.id  
  key_name      = "deu1-testkey-001"
  vpc_security_group_ids = [aws_security_group.deu1_postgres_sg_001.id]  
  
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "deu1-postgres-001"
    Owner = "Hung"
  }
}


