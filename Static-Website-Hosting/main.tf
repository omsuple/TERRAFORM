terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length = 8

}
resource "aws_s3_bucket" "website-bucket" {
  bucket = "website-bucket-${random_id.rand_id.hex}"

}

resource "aws_s3_bucket_public_access_block" "pub_access" {
  bucket = aws_s3_bucket.website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
} # Refer terraform aws registry documentation for this!!

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.website-bucket.id
  policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          Sid : "PublicReadGetObject",
          Effect : "Allow",
          Principal : "*",
          Action : "s3:GetObject",
          Resource : "arn:aws:s3:::${aws_s3_bucket.website-bucket.id}/*"
        }
      ]
    }
  )
} # jsonencode helps us write our policy in json language 

resource "aws_s3_bucket_website_configuration" "web-app" {
  bucket = aws_s3_bucket.website-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "obj" {
  bucket       = aws_s3_bucket.website-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "obj1" {
  bucket       = aws_s3_bucket.website-bucket.bucket
  source       = "./styles.css"
  key          = "styles.css"
  content_type = "text/css"

}

output "url" {
  value = aws_s3_bucket_website_configuration.web-app.website_endpoint

}
