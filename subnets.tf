resource "aws_subnet" "deu1-public-subnet-a-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "deu1-public-subnet-a-001"
    Owner = "Hung"
  }
}

resource "aws_subnet" "deu1-private-subnet-a-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "deu1-private-subnet-a-001"
    Owner = "Hung"
  }
}

resource "aws_subnet" "deu1-data-subnet-a-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "deu1-data-subnet-a-001"
    Owner = "Hung"
  }
}

resource "aws_subnet" "deu1-public-subnet-b-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "deu1-public-subnet-b-001"
    Owner = "Hung"
  }
}

resource "aws_subnet" "deu1-private-subnet-b-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "deu1-private-subnet-b-001"
    Owner = "Hung"
  }
}

resource "aws_subnet" "deu1-data-subnet-b-001" {
  vpc_id     = aws_vpc.deu1-vpc-001.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "deu1-data-subnet-b-001"
    Owner = "Hung"
  }
}

