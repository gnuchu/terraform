
provider "aws" {
  profile = "default"
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami = "ami-0d8e27447ec2c8410"
  instance_type = "t2.micro"

  depends_on = ["aws_s3_bucket.example"]

  key_name = "deployer-key"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_dns} > dns.txt"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-getting-started-guide-gnuchu"
  acl = "private"
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "${file("c:\\users\\jgriffiths\\.ssh\\aws_keypair.pub")}"
}

