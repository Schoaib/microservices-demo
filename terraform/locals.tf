##################################################
# Locally rendered variable reused across the code
##################################################

locals {
  name            = "microservice-demo"
  cluster_version = "1.22"
  region          = "eu-west-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}