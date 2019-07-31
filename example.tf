provider "aws" {
  profile = "default"
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami = "ami-0bdfa1adc3878cd23"
  instance_type = "t2.micro"
}

