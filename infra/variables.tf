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
  default     = "virtualbusinessmailbox.com"
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

variable "stripe_secret_key" {
  type      = string
  sensitive = true
}

variable "stripe_webhook_secret" {
  type      = string
  sensitive = true
}

variable "teams_webhook_url" {
  type      = string
  sensitive = true
}
