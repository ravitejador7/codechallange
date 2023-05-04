resource "aws_ebs_volume" "codechallenge-ebs" {
  availability_zone = "us-east-1a"
  size              = var.ebs_size
  type              = "gp2"
}

resource "aws_volume_attachment" "codechallenge-ebs-attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.codechallenge-ebs.id
  instance_id = aws_instance.codechallenge-instance.id
}
