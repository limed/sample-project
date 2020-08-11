variable "region" {
  default = "us-west-2"
}

variable "project_name" {}

variable "environment" {}

variable "build_timeout" {
  default = "60"
}

variable "source_config" {
  description = "Source pipeline config"
  type = map({
    name               = string
    github_oauth_token = string
    repo_owner         = string
    repo_name          = string
    repo_branch        = string
    poll_source_change = bool
  })
  default = {}
}
