#GCP provider

provider "google" {
    project = var.gcp_project
    region  = var.gcp_region
    impersonate_service_account = var.gcp_service_account
    
}