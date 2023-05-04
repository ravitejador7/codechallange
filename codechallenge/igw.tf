resource "aws_internet_gateway" "codechallenge-igw" {
  vpc_id = aws_vpc.codechallenge-vpc.id

  tags = {
    Name = "codechallenge"
  }
}
