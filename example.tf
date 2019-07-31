
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
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfLQNbz8B99KkarAX4p92tVSnt/IpdwAqpETQJkJYiZQ6I1Spy8lFaViKlkyXaRN9/wc7UyxxENNeAfWkM5DImnzR2fSxQ10w+GHq63zx25KAJAQXFDwzilyoOKvWz5dyo69zW1srAYvRdKAMBwpd6mGM6dpx0uJn2s5UmhizzuRCDkT2PCa5KmmsyKGu5LDDn2maGQRCOoQGyQ6+Wgz/QM2IrSwOPvXIVqf3CejFuJoB55oPQWqcwmA//6xs1pe4VdqA/sMxtf3zZJmtegJhz8forO1IWHBPTYcXeznKDSDHbFx7jOad/0/Vda/bxeE7IPFO0PQs6cd/SNDnbtYgh verint\\jgriffiths@GLA-DEVOP-138WVN"
}

