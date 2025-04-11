resource "aws_vpc" "deu1-vpc-001" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name  = "deu1-vpc-001"
    Owner = "Hung"
  }
}
