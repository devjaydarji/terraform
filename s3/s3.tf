

provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

##eachmodule one by one execute 

resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket-testqqq"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
   bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_object" "images" {
   bucket = "my-bucket-testqqq"
   key    = "images/"
   source = "/dev/null"
}

resource "aws_s3_bucket_object" "logs" {
   bucket = "my-bucket-testqqq"
   key    = "logs/"
  source = "/dev/null"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.bucket.bucket

 rule {
    id = "log"

    expiration {
      days = 90
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "tmp"

    filter {
      prefix = "tmp/"
    }

    expiration {
      date = "2023-01-13T00:00:00Z"
    }

    status = "Enabled"
  }
}

