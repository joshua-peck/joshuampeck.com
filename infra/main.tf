terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    
  }
  backend "gcs" {
    bucket = "joshuampeck-tfstate"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ─────────────────────────────────────────
# GCS Bucket
# ─────────────────────────────────────────

resource "google_storage_bucket" "site" {
  name                        = var.domain
  location                    = "US" # multi-region for CDN performance
  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["https://${var.domain}", "https://www.${var.domain}"]
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Allow allUsers for public static site serving via Cloud CDN
resource "google_project_organization_policy" "allow_all_users" {
  project    = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      all = true
    }
  }
}

resource "google_storage_bucket_iam_member" "public_read" {
  bucket     = google_storage_bucket.site.name
  role       = "roles/storage.objectViewer"
  member     = "allUsers"
  depends_on = [google_project_organization_policy.allow_all_users]
}

# ─────────────────────────────────────────
# Static IP
# ─────────────────────────────────────────

resource "google_compute_global_address" "site" {
  name        = "${local.name_prefix}-ip"
  description = "Static IP for ${var.domain}"
}

# ─────────────────────────────────────────
# Backend Bucket + CDN
# ─────────────────────────────────────────

resource "google_compute_backend_bucket" "site" {
  name        = "${local.name_prefix}-backend"
  bucket_name = google_storage_bucket.site.name
  enable_cdn  = true

  # Brotli + gzip negotiation
  compression_mode = "AUTOMATIC"

  cdn_policy {
    cache_mode  = "CACHE_ALL_STATIC"
    default_ttl = 3600  # 1 hour for HTML
    max_ttl     = 86400 # 24 hours max
    client_ttl  = 3600

    # Serve stale content while revalidating
    serve_while_stale = 86400

    negative_caching = true
    negative_caching_policy {
      code = 404
      ttl  = 60 # cache 404s for 60s only
    }
  }
}

# ─────────────────────────────────────────
# SSL Certificate (Google-managed)
# ─────────────────────────────────────────

resource "google_compute_managed_ssl_certificate" "site" {
  name = "${local.name_prefix}-cert"

  managed {
    domains = [
      var.domain,
      "www.${var.domain}"
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ─────────────────────────────────────────
# URL Maps
# ─────────────────────────────────────────

# Main URL map — HTTPS traffic
resource "google_compute_url_map" "site" {
  name            = "${local.name_prefix}-urlmap"
  default_service = google_compute_backend_bucket.site.id

  # www → apex redirect
  host_rule {
    hosts        = ["www.${var.domain}"]
    path_matcher = "www-redirect"
  }

  path_matcher {
    name = "www-redirect"
    default_url_redirect {
      host_redirect          = var.domain
      redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
      strip_query            = false
    }
  }

  # Security + performance headers
  header_action {
    response_headers_to_add {
      header_name  = "Strict-Transport-Security"
      header_value = "max-age=31536000; includeSubDomains; preload"
      replace      = true
    }
    response_headers_to_add {
      header_name  = "X-Frame-Options"
      header_value = "SAMEORIGIN"
      replace      = true
    }
    response_headers_to_add {
      header_name  = "X-Content-Type-Options"
      header_value = "nosniff"
      replace      = true
    }
    response_headers_to_add {
      header_name  = "Referrer-Policy"
      header_value = "strict-origin-when-cross-origin"
      replace      = true
    }
    response_headers_to_add {
      header_name  = "Permissions-Policy"
      header_value = "camera=(), microphone=(), geolocation=()"
      replace      = true
    }
  }
}

# HTTP → HTTPS redirect URL map
resource "google_compute_url_map" "http_redirect" {
  name = "${local.name_prefix}-http-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

# ─────────────────────────────────────────
# Proxies
# ─────────────────────────────────────────

resource "google_compute_target_https_proxy" "site" {
  name             = "${local.name_prefix}-https-proxy"
  url_map          = google_compute_url_map.site.id
  ssl_certificates = [google_compute_managed_ssl_certificate.site.id]

  # Enable HTTP/2
  quic_override = "ENABLE"
}

resource "google_compute_target_http_proxy" "redirect" {
  name    = "${local.name_prefix}-http-proxy"
  url_map = google_compute_url_map.http_redirect.id
}

# ─────────────────────────────────────────
# Forwarding Rules
# ─────────────────────────────────────────

resource "google_compute_global_forwarding_rule" "https" {
  name                  = "${local.name_prefix}-https"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.site.id
  ip_address            = google_compute_global_address.site.address
}

resource "google_compute_global_forwarding_rule" "http" {
  name                  = "${local.name_prefix}-http"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.redirect.id
  ip_address            = google_compute_global_address.site.address
}
