terraform {
  backend "gcs" {
    credentials = "serviceaccount.json"
    bucket      = "gkebucket123"
    prefix      = "state"
  }
}
