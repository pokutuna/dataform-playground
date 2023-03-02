locals {
  dataform_agent_roles = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/bigquery.user",
    "roles/dataform.editor",
    "roles/dataform.serviceAgent",
    "roles/logging.logWriter",
    "roles/secretmanager.secretAccessor",
    "roles/workflows.invoker",
  ])
}

# resource "google_project_iam_member" "dataform_agent_roles" {
#   for_each = local.dataform_agent_roles
#   project  = var.project
#   role     = each.value
#   member   = "serviceAccount:${var.dataform_agent_email}"
# }

# CI などから Dataform を実行するためのサービスアカウント
resource "google_service_account" "dataform" {
  account_id   = "dataform"
  display_name = "dataform"
  description  = "Dataform 実行用サービスアカウント"
}

resource "google_project_iam_member" "dataform_roles" {
  for_each = local.dataform_agent_roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.dataform.email}"
}
