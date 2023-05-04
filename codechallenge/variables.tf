variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_block_a" {
  type    = string
  default = "10.0.0.0/17"
}

variable "cidr_block_b" {
  type    = string
  default = "10.0.128.0/17"
}
variable "availability_zone_a" {
  type    = string
  default = "us-east-1a"
}

variable "availability_zone_b" {
  type    = string
  default = "us-east-1b"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ebs_size" {
  type    = number
  default = 30
}