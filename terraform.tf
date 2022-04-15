terraform {
  backend "gcs" {
    credentials = "./terraform-gkecluster-keyfile.json"
    bucket      = "<bucket-name>"
    prefix      = "terraform/state"
  }
}





