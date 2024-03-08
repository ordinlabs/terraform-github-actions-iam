Github Actions AWS IAM Terraform Module
=====================================

```
module gha_iam {
  source = "git@github.com:ordinlabs/terraform-github-actions-iam.git"
  federated_principal_arn = data.terraform_remote_state.github_actions.outputs.oidc_arn
  github_repos = [
    "github-org/github-repo"
  ]
  iam_policy_arns = [
    "iam_policy_arn"
  ]
  github_repo_arn_var_name = "AWS_ACCESS_ROLE_ARN"
}

```