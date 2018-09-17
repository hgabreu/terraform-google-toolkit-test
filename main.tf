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

module "vpc" {
  source = "../terraform-google-network"
  project_id = "cit-henriqueg-tf-test-33d7"
  network_name = "myvpc"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }
}
