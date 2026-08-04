# Bucket to store website
resource "google_storage_bucket" "website" {
  name = "example-website-by-yuri"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}
#Make the bucket public

resource "google_storage_bucket_iam_member" "public_rule" {
  bucket = google_storage_bucket.website.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

#Upload index.html to the bucket

resource "google_storage_bucket_object" "static_site_src" {
  name   = "index.html"
  bucket = google_storage_bucket.website.name
  source = "../website/index.html"
  content_type = "text/html"
}

#Reserving a external IP address 
resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip"
}

#Adding a CDN to the bucket

resource "google_compute_backend_bucket" "website-backend" {
  name        = "website-backend"
  bucket_name = google_storage_bucket.website.name
  enable_cdn  = true
  description = "COntains files needed to serve the website"
  
}

# GCP Url Map
resource "google_compute_url_map" "website-map" {
  name            = "website-url-map"
  default_service = google_compute_backend_bucket.website-backend.self_link
  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_bucket.website-backend.self_link
  }
}

#GCP HTTP Proxy
resource "google_compute_target_http_proxy" "website-proxy" {
    name    = "website-http-proxy"
    url_map = google_compute_url_map.website-map.self_link
}

#GCP Forwarding Rule
resource "google_compute_global_forwarding_rule" "default-website-rule" {
    name       = "website-forwarding-rule"
    load_balancing_scheme = "EXTERNAL"
    ip_protocol = "TCP"
    ip_address = google_compute_global_address.website_ip.address
    target     = google_compute_target_http_proxy.website-proxy.self_link
    port_range = "80"
    
}