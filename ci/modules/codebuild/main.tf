
locals {
  source_config_defaults = {
    "name"               = "Source"
    "repo_branch"        = "master"
    "poll_source_change" = true
    "github_oauth_token" = data.aws_ssm_parameter.github.value
  }
  source_config = merge(local.source_config_defaults, var.source_config)
}

data "aws_ssm_parameter" "github" {
  name = "/ci/${var.enviroment}/${var.project_name}/github_oauth_token"
}

resource "aws_codepipeline" "main" {
  name          = var.project_name
  description   = "CI Pipeline for project ${var.project_name}"
  build_timeout = var.build_timeout

  stage {
    name = "Source"

    action {
      name     = local.source_config["name"]
      category = "Source"
      owner    = "ThirdParty"
      provider = "Github"
      version  = "1"

      configuration {
        OAuthToken           = local.source_config["github_oauth_token"]
        Owner                = local.source_config["repo_owner"]
        Repo                 = local.source_config["repo_name"]
        Branch               = local.source_config["repo_branch"]
        PollForSourceChanges = local.source_config["poll_source_changes"]
      }
    }
  }
}
