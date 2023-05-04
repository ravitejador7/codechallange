resource "aws_route_table" "codechallenge-route-private" {
  vpc_id = aws_vpc.codechallenge-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.codechallenge-nat.id
  }


  tags = {
    Name = "codechallenge-private"
  }
}

resource "aws_route_table" "codechallenge-route-public" {
  vpc_id = aws_vpc.codechallenge-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.codechallenge-igw.id
  }


  tags = {
    Name = "codechallenge-public"
  }
}


resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.codechallenge-private-subnet-a.id
  route_table_id = aws_route_table.codechallenge-route-private.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.codechallenge-public-subnet-b.id
  route_table_id = aws_route_table.codechallenge-route-public.id
}
