locals {
  dataform_agent_roles = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/bigquery.user",
    "roles/dataform.editor",
    "roles/dataform.serviceAgent",
    "roles/logging.logWriter",
    "roles/workflows.invoker",
  ])
}

locals {
  dataform_agent_member = "serviceAccount:service-${data.google_project.this.number}@gcp-sa-dataform.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "dataform_agent_roles" {
  for_each = local.dataform_agent_roles
  project  = var.project
  role     = each.value
  member   = local.dataform_agent_member
}

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
  member   = google_service_account.dataform.member
}


resource "google_secret_manager_secret_iam_member" "github_repo_token" {
  for_each = toset([
    google_service_account.dataform.member,
    local.dataform_agent_member,
  ])

  secret_id = google_secret_manager_secret.github_repo_token.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value
}
