# ── GCP Resource Manager Tags ───────────────────────────────────────────────
# Creates an "environment" tag key at the org level, tag values for each
# environment, and binds the current environment to this project.

data "google_project" "current" {}

locals {
  env_tag_values = toset(["Development", "Staging", "Production"])
  env_map = {
    dev     = "Development"
    staging = "Staging"
    prod    = "Production"
  }
}

resource "google_tags_tag_key" "environment" {
  parent     = "projects/${data.google_project.current.number}"
  short_name = "environment"
  description = "Project environment designation"
}

resource "google_tags_tag_value" "environment" {
  for_each = local.env_tag_values

  parent     = google_tags_tag_key.environment.id
  short_name = each.value
}

resource "google_tags_tag_binding" "environment" {
  parent    = "//cloudresourcemanager.googleapis.com/projects/${data.google_project.current.number}"
  tag_value = google_tags_tag_value.environment[local.env_map[var.env]].id
}
