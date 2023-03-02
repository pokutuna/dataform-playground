terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.55"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.55"
    }
  }

  backend "gcs" {
    bucket = "pokutuna-dataform-playground-tfstate"
  }
}

provider "google" {
  project = "pokutuna-playground"
  region  = "asia-northeast1"
}

provider "google-beta" {
  project = "pokutuna-playground"
  region  = "asia-northeast1"
}
