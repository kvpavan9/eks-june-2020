provider "aws" {
  region = "us-east-1"
  access_key = "AKIA4RHBSJ5KWK2XDXFN"
  secret_key = "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"
}
data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

