terraform {
  # Версия terraform
  required_version = "~>0.12.8"
}

provider "google" {
  version = "2.15"
  project = var.project
  region = var.region
}

module "app" {
  source = "../modules/app"
  project = var.project
  pubkeypath = var.pubkeypath
  zone = var.zone
  disk_image_app = var.disk_image_app
}

module "db" {
  source = "../modules/db"
  project = var.project
  pubkeypath = var.pubkeypath
  zone = var.zone
  disk_image_db = var.disk_image_db
}

module "vpc" {
  source = "../modules/vpc"
  project = var.project
  source_ranges = ["0.0.0.0/0"]
}