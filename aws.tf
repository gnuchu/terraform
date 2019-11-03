provider "aws" {
  profile = "default"
  region = "eu-west-2"
}

resource "aws_instance" "playground" {
  ami = "ami-0d8e27447ec2c8410"
  instance_type = "t2.micro"

  // depends_on = ["aws_s3_bucket.example"]

  key_name = "deployer-key"

  provisioner "local-exec" {
    command = "echo DNS: ${aws_instance.playground.public_dns} > dns.txt; echo IP:  ${aws_instance.playground.public_ip} >> dns.txt"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.playground.id
}

// resource "aws_s3_bucket" "example" {
//   bucket = "terraform-getting-started-guide-gnuchu"
//   acl = "private"
// }

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "${file("/Users/gnuchu/.ssh/id_rsa.pub")}"
}

