provider "aws" {
  region = var.region
}

module "pipeline" {
  source       = "./modules/codepipeline"
  project_name = "test-project"
  environment  = "dev"
}
