variable "region" {
  type    = string
  default = "europe-west1"
}


provider "google" {
  credentials = file("~/code/credentials/i3s-dev-b538d40535d9.json")
  project     = "i3s-dev"
  region      = var.region
  zone        = "europe-west1-a"
}

resource "google_sql_database_instance" "master" {
  name             = "is2-master-instance"
  database_version = "POSTGRES_11"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}