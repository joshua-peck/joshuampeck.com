#!/bin/bash
set -euo pipefail

# ─────────────────────────────────────────
# Config
# ─────────────────────────────────────────
INFRA_DIR="$(dirname "$0")/infra"
PROJECT=$(cd "$INFRA_DIR" && terraform output -raw project_id)
BUCKET=$(cd "$INFRA_DIR" && terraform output -raw bucket_name)
URL_MAP=$(cd "$INFRA_DIR" && terraform output -raw url_map_name)

echo "→ Project: $PROJECT"
echo "→ Bucket:  $BUCKET"
echo "→ URL Map: $URL_MAP"
echo ""

# ─────────────────────────────────────────
# Build
# ─────────────────────────────────────────
echo "→ Installing dependencies..."
npm install --prefer-offline --no-audit --no-fund
echo "✓ Dependencies installed"

echo "→ Building Hugo..."
hugo --minify --enableGitInfo
echo "✓ Build complete"

# ─────────────────────────────────────────
# Sync to GCS
# ─────────────────────────────────────────
echo "→ Syncing to GCS..."
gcloud storage rsync public/ gs://$BUCKET --project "$PROJECT" --recursive --delete-unmatched-destination-objects
echo "✓ Sync complete"

# ─────────────────────────────────────────
# Cache headers
# ─────────────────────────────────────────
echo "→ Setting cache headers..."

echo "  → HTML — short TTL, must revalidate"
gcloud storage objects update "gs://$BUCKET/**.html" \
  --project "$PROJECT" --cache-control="public, max-age=300, must-revalidate" 2>/dev/null || true

echo "  → Fingerprinted CSS/JS — immutable, cache forever"
gcloud storage objects update "gs://$BUCKET/css/**" "gs://$BUCKET/js/**" \
  --project "$PROJECT" --cache-control="public, max-age=31536000, immutable" 2>/dev/null || true

echo "  → Fonts — long TTL"
gcloud storage objects update "gs://$BUCKET/fonts/**" \
  --project "$PROJECT" --cache-control="public, max-age=604800" 2>/dev/null || true

echo "  → Images — one week"
gcloud storage objects update "gs://$BUCKET/images/**" \
  --project "$PROJECT" --cache-control="public, max-age=604800" 2>/dev/null || true

echo "  → Sitemap + robots — short TTL"
gcloud storage objects update "gs://$BUCKET/sitemap.xml" "gs://$BUCKET/robots.txt" \
  --project "$PROJECT" --cache-control="public, max-age=3600" 2>/dev/null || true

echo "✓ Cache headers set"

# ─────────────────────────────────────────
# Invalidate CDN cache
# ─────────────────────────────────────────
echo "→ Invalidating CDN cache..."
gcloud compute url-maps invalidate-cdn-cache "$URL_MAP" \
  --project "$PROJECT" \
  --global \
  --path "/*" \
  --async \
  --quiet
echo "✓ CDN invalidation queued [ASYNC]"

echo " "
echo "✓ Deploy complete"
