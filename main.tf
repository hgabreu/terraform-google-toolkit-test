#deleted gsuite_override.tf file in project-factory source folder

module "projectf" {
  source              = "../terraform-google-project-factory"
  name                = "cit-henriqueg-tf-test"
  random_project_id   = "true"
  org_id              = "1734241926"
  billing_account     = "00FEAB-036EA4-E2DEF7"
  credentials_path    = "/home/henriqueg/.config/gcloud/application_default_credentials.json"

  activate_apis = [
    "compute.googleapis.com",
  ]
}

output "pid" {
  value = "${module.projectf.project_id}"
}

module "vpc" {
  source = "../terraform-google-network"
  project_id = "${module.projectf.project_id}"
  network_name = "myvpc3"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]
  }
}

module "logs" {
  source = "../terraform-google-log-export"
  name = "mylogexport"
  project = "${module.projectf.project_id}"
  bigquery = {
    name = "isthisdatasetname"
    project = "kohls-ciandt-1"
  }
}
