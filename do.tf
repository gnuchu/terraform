variable "do_token" {}
variable "droplet_name" {}
variable "project_name" {}
variable "project_description" {}
variable "project_purpose" {}
variable "project_environment" {}
variable "droplet_project" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "playground" {
  name = "${var.droplet_name}"
  image = "ubuntu-18-04-x64"
  region = "lon1"
  size = "1gb"
  depends_on = [var.droplet_project]
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

resource "digitalocean_project" "terraform" {
  name = var.project_name
  description = var.project_description
  purpose = var.project_purpose
  environment = var.project_environment
}

resource "digitalocean_ssh_key" "default" {
  name = "terraform_id"
  public_key = file("keys/terraform_id.pub")
}
