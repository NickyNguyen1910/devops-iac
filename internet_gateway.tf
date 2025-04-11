resource "aws_internet_gateway" "deu1-igw-001" {
  vpc_id = aws_vpc.deu1-vpc-001.id

  tags = {
    Name = "deu1-igw-001"
    Owner = "Hung"
  }
}