resource "aws_vpc" "codechallenge-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "codechallenge"
  }
}
