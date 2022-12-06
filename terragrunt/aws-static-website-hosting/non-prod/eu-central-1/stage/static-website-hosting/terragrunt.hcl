locals {
  common_vars      = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  prefix = local.environment_vars.locals.prefix
  environment = local.environment_vars.locals.environment
}

terraform {
  source = "github.com/twistedFantasy/terraform-modules-v2.git//aws-static-website-hosting?ref=v0.0.1"
}

inputs = {
  project      = local.common_vars.project
  environment  = local.environment

  common_tags = {
    Environment = local.environment
    Owner = local.common_vars.owner
  }
}

include "root" {
  path = find_in_parent_folders()
}
