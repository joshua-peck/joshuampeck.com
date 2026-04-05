output "static_ip" {
  description = "Point DNS A records for @ and www to this IP"
  value       = google_compute_global_address.site.address
}

output "bucket_name" {
  description = "GCS bucket name — use in deploy script"
  value       = google_storage_bucket.site.name
}

output "bucket_url" {
  description = "GCS bucket URL"
  value       = google_storage_bucket.site.url
}

output "cdn_backend" {
  description = "CDN backend bucket name — use for cache invalidation"
  value       = google_compute_backend_bucket.site.name
}

output "project_id" {
  description = "GCP project ID — use in deploy script"
  value       = var.project_id
}

output "url_map_name" {
  description = "URL map name — use for CDN cache invalidation"
  value       = google_compute_url_map.site.name
}

output "certificate_status" {
  description = "Command to check SSL cert status (wait for ACTIVE before HTTPS works)"
  value       = "gcloud compute ssl-certificates describe ${google_compute_managed_ssl_certificate.site.name} --global --project=${var.project_id} --format='value(managed.status)'"
}

output "dns_instructions" {
  description = "DNS records to create at your registrar"
  value       = <<-EOT
    Create these DNS records at your registrar:

    Type  Name  Value
    ────  ────  ─────
    A     @     ${google_compute_global_address.site.address}
    A     www   ${google_compute_global_address.site.address}

    SSL cert provisions automatically after DNS propagates (10-30 min).
    Check status command: terraform output -raw certificate_status
  EOT
}
