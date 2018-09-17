provider "google" {
  project = "kohls-ciandt-1"
}

#deleted gsuite_override.tf file in project-factory source folder

module "project-factory" {
  source              = "../terraform-google-project-factory"
  name                = "cit-henriqueg-tf-test"
  random_project_id   = "true"
  org_id              = "1734241926"
  billing_account     = "00FEAB-036EA4-E2DEF7"
  credentials_path    = "/home/henriqueg/.config/gcloud/application_default_credentials.json"
}

