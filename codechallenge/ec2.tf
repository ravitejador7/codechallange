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


resource "tls_private_key" "codechallenge-private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "codechallenge-keypair" {
  key_name   = "example-keypair"
  public_key = tls_private_key.codechallenge-private.public_key_openssh
}

resource "aws_instance" "codechallenge-instance" {
  ami           = "ami-0889a44b331db0194"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.codechallenge-private-subnet-a.id
  associate_public_ip_address = false
  tags = {
    Name = "codechallenge-instance"
  }
  key_name      = aws_key_pair.codechallenge-keypair.key_name
  iam_instance_profile = aws_iam_instance_profile.codechallenge-ec2-profile.name

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = aws_key_pair.codechallenge-keypair.public_key
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3",
      "sudo amazon-linux-extras install -y epel",
      "sudo yum install -y python3-pip",
      "sudo pip3 install boto3",
      "cd /home/ec2-user/",
      "aws s3 cp s3://codechallenge-bucket/pythonscript .",
      "chmod +x /home/ec2-user/script.py",
      "python3 /home/ec2-user/script.py",
      "echo 'Mount Commands'",
      "sudo mkdir /data",
      "sudo mkfs -t ext4 /dev/xvdf",
      "sudo mount /dev/xvdf /data",
      "sudo echo '/dev/xvdf /data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab"
    ]
  }
}
