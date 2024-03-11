Github Actions AWS IAM Terraform Module
=====================================
## Example Usage

```hcl
module gha_iam {
  source = "git@github.com:ordinlabs/terraform-github-actions-iam.git?ref=main"
  federated_principal_arn = data.terraform_remote_state.github_actions.outputs.oidc_arn
  github_repos = [
    "github-org/github-repo"
  ]
  iam_policy_arns = [
    "iam_policy_arn"
  ]
}

```

## Inputs

| Name                    | Description                                                           | Type         | Default                             | Required |
|-------------------------|-----------------------------------------------------------------------|--------------|-------------------------------------|:--------:|
| federated_principal_arn | aws_iam_openid_connect_provider arn from aws                          | `string`     |                                     |   yes    |
| github_repos            | List of github repos to allow use of defined polocies                 | `list(string)` |                                     |   yes    |
| iam_policy_arns         | List of iam policy arns to apply                                      | `list(string)` |                                     |    yes    |
| github_repo_arn_var_name | GitHub repo actions variable name to put the generated role arn value | `string`     | `AWS_OIDC_ROLE_ARN`                 |    no    |
| github_oidc_host        | GitHubs OIDC host name                                                | `string`     | `token.actions.githubusercontent.com` |    no    |
| github_oidc_claim       | GitHubs OIDC claim see https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#understanding-the-oidc-token  | `string`     | `*`  |    no    |
| assume_role_arns        | Additional role ARNs to allow to assume IAM role                      | `list(string)`           | `[]`                                |    no    |
| tags                    | Tags to apply to the AWS resources created by this module             | `map(string)`           | `{}`                                |    no    |

## Outputs

| Name | Description                          |
|------|--------------------------------------|
| github_repo_role_arns | Map of iam_role.name => iam_role.arn |
