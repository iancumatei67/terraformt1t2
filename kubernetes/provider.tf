terraform {
  required_version = "~> 1.9.4"

  backend "gcs" {
    bucket = "miancu-t1t2-tfstate"
    prefix = "kubernetes"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.40.0"
    }
  }
}

provider "google" {
  region  = "europe-west-1"
  zone    = "europe-west1-a"
  project = "gd-gcp-gridu-devops-t1-t2"
}