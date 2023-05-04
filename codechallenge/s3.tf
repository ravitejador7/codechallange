resource "aws_s3_bucket" "codechallenge-bucket" {
  bucket = "codechallenge-bucket-python"
}

resource "aws_s3_object" "codechallenge-object" {
  bucket = aws_s3_bucket.codechallenge-bucket.id
  key    = "pythonscript.py"
  source = "C:/Users/Ravi/Desktop/Ravicode/codechallenge/src/script.py"
}