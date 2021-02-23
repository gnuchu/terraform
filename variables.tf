variable "region" {
  default = "eu-west-2"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "eu-west-2" = "ami-0d8e27447ec2c8410"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

