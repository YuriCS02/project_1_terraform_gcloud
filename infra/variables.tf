variable "gcp_service_account" {
  description = "The service account to impersonate for GCP operations."
  type        = string
}

variable "gcp_project" {
  description = "The GCP project ID."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources."
  type        = string
}