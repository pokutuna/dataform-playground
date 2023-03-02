resource "google_secret_manager_secret" "github_repo_token" {
  secret_id = "github_repo_token"

  # https://github.com/settings/personal-access-tokens/844617

  replication {
    automatic = true
  }
}

data "google_secret_manager_secret_version" "github_repo_token" {
  secret = google_secret_manager_secret.github_repo_token.id
}
