resource "google_dataform_repository" "dataform_playground" {
  provider = google-beta
  name     = "dataform-playground"
  region   = "asia-east1"

  git_remote_settings {
    url            = "https://github.com/pokutuna/dataform-playground.git"
    default_branch = "main"

    authentication_token_secret_version = data.google_secret_manager_secret_version.github_repo_token.id
  }
}
