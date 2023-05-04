resource "aws_subnet" "codechallenge-private-subnet-a" {
  vpc_id                  = aws_vpc.codechallenge-vpc.id
  cidr_block              = var.cidr_block_a
  availability_zone       = var.availability_zone_a

  tags = {
    "Name" = "codechallenge-private"
  }
}

resource "aws_subnet" "codechallenge-public-subnet-b" {
  vpc_id                  = aws_vpc.codechallenge-vpc.id
  cidr_block              = var.cidr_block_b
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    "Name" = "codechallenge-public"
  }
}
