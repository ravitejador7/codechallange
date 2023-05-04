resource "aws_nat_gateway" "codechallenge-nat" {
  allocation_id = aws_eip.codechallenge-eip.id
  subnet_id     = aws_subnet.codechallenge-public-subnet-b.id
}

resource "aws_eip" "codechallenge-eip" {
  vpc = true
}