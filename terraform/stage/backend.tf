terraform {
  backend "gcs" {
    bucket = "test-bucket-${var.project}"
    prefix = "terraform/state/stage"
  }
}