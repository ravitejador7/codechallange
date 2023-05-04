resource "aws_iam_role" "codechallenge-instance-role" {
  name = "codechallenge-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codechallenge-ec2-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.codechallenge-instance-role.name
}

resource "aws_iam_role_policy_attachment" "codechallenge-ec2-bucket-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.codechallenge-instance-role.name
}

resource "aws_iam_instance_profile" "codechallenge-ec2-profile" {
  name = "codechallenge-ssm-instance-profile"
  role = aws_iam_role.codechallenge-instance-role.name
}

resource "aws_instance" "codechallenge-instance" {
  ami           = "ami-0889a44b331db0194"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.codechallenge-private-subnet-a.id
  associate_public_ip_address = false
  tags = {
    Name = "codechallenge-instance"
  }
  iam_instance_profile = aws_iam_instance_profile.codechallenge-ec2-profile.name

  user_data = <<-EOF
  #!/bin/bash
  cd /root
  aws s3 cp s3://codechallenge-bucket-python/pythonscript.py .
  chmod +x pythonscript.py
  python3 pythonscript.py
  sudo mkdir /data
  sudo mkfs -t ext4 /dev/xvdf -y
  sudo mount /dev/xvdf /data
  EOF
}
