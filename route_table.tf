#Public Route Table

resource "aws_route_table" "deu1-public-route-table-001" {
  vpc_id = aws_vpc.deu1-vpc-001.id

  route {
    cidr_block = "0.0.0.0/0"  
    gateway_id = aws_internet_gateway.deu1-igw-001.id
  }

  tags = {
    Name  = "deu1-public-route-table-001"
    Owner = "Hung"
  }
}

resource "aws_route_table_association" "deu1-public-subnet-assoc-001" {
  subnet_id      = aws_subnet.deu1-public-subnet-a-001.id
  route_table_id = aws_route_table.deu1-public-route-table-001.id
}

resource "aws_route_table_association" "deu1-public-subnet-assoc-002" {
  subnet_id      = aws_subnet.deu1-public-subnet-b-001.id  
  route_table_id = aws_route_table.deu1-public-route-table-001.id
}


#Private Route Table

resource "aws_route_table" "deu1-private-route-table-001" {
  vpc_id = aws_vpc.deu1-vpc-001.id

  route {
    cidr_block = "0.0.0.0/0"  
    network_interface_id = aws_instance.nat_instance.primary_network_interface_id
  }

  tags = {
    Name  = "deu1-private-route-table-001"
    Owner = "Hung"
  }
}

resource "aws_route_table_association" "deu1-private-subnet-assoc-001" {
  subnet_id      = aws_subnet.deu1-private-subnet-a-001.id
  route_table_id = aws_route_table.deu1-private-route-table-001.id
}

resource "aws_route_table_association" "deu1-private-subnet-assoc-002" {
  subnet_id      = aws_subnet.deu1-private-subnet-b-001.id  
  route_table_id = aws_route_table.deu1-private-route-table-001.id
}


#Data Route Table

resource "aws_route_table" "deu1-data-route-table-001" {
  vpc_id = aws_vpc.deu1-vpc-001.id

  route {
    cidr_block = "10.0.0.0/16" 
    gateway_id = "local"
  }

  tags = {
    Name  = "deu1-data-route-table-001"
    Owner = "Hung"
  }
}

resource "aws_route_table_association" "deu1-data-subnet-assoc-001" {
  subnet_id      = aws_subnet.deu1-data-subnet-a-001.id
  route_table_id = aws_route_table.deu1-data-route-table-001.id
}

resource "aws_route_table_association" "deu1-data-subnet-assoc-002" {
  subnet_id      = aws_subnet.deu1-data-subnet-b-001.id  
  route_table_id = aws_route_table.deu1-data-route-table-001.id
}