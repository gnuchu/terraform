terraform {
  backend "remote" {
    organization = "gnuchu"

    workspaces {
      name = "DEV"
    }
  }
}