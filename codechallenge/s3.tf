resource "aws_s3_bucket" "codechallenge-bucket" {
  bucket = "codechallenge-bucket"
  key    = "pythonscript"
  source = "src/script.py"
}