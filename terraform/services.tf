locals {
  services = toset([
    "bigquery.googleapis.com",
    "cloudscheduler.googleapis.com",
    "datacatalog.googleapis.com",
    "dataform.googleapis.com",
    "datalineage.googleapis.com",
    "drive.googleapis.com",
    "iamcredentials.googleapis.com",
    "secretmanager.googleapis.com",
    "sheets.googleapis.com",
    "storage.googleapis.com",
    "workflows.googleapis.com",
  ])
}

resource "google_project_service" "service" {
  for_each = local.services
  project  = var.project
  service  = each.value
}
