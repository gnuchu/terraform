
provider "aws" {
  profile = "default"
  region = var.region
}

resource "aws_instance" "example" {
  ami = var.amis[var.region]
  instance_type = var.instance_type

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

output "ami" {
  value = aws_instance.example.ami
}

output "public_dns" {
  value = aws_instance.example.public_dns
}


