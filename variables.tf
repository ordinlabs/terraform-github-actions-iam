variable federated_principal_arn {
  type = string
}

variable github_repos {
  type = list(string)
}

variable iam_policy_arns {
  type = list(string)
}

variable github_oidc_host {
  type = string
  default = "token.actions.githubusercontent.com"
}

variable github_repo_arn_var_name {
  type = string
  default = "AWS_OIDC_ROLE_ARN"
  description = "Set to null to avoid setting the AWS role ARN on the repositories"
}

variable tags {
  type = map(string)
  description = "Tags to apply to resources"
  default = {}
}

variable "assume_role_arns" {
  type = list(string)
  default = []
}