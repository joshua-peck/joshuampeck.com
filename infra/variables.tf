variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "env" {
  type        = string
  description = "gcp cloud environment to deploy to: dev, staging, prod"
  default     = "dev"
}


variable "domain" {
  description = "Primary domain (no www)"
  type        = string
  default     = "joshuampeck.com"
}

variable "region" {
  description = "GCP region for regional resources"
  type        = string
  default     = "us-central1"
}

locals {
  # Sanitize domain for use in resource names
  name_prefix = replace(var.domain, ".", "-")
}
