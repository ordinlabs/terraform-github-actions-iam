resource aws_iam_role gh_repo_role {
  for_each = {for repo in var.github_repos : repo => repo}
  name_prefix = format("%.38s", "gha_${replace(replace(each.key, "/", "_"), "-", "_")}")
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      [
        {
          Effect : "Allow",
          Principal : {
            "Federated" : var.federated_principal_arn
          },
          Action : "sts:AssumeRoleWithWebIdentity",
          Condition : {
            "StringLike" : {
              "${var.github_oidc_host}:sub" : "repo:${each.key}:*"
            },
            "StringEquals" : {
              "${var.github_oidc_host}:aud" : "sts.amazonaws.com"
            }
          }
        }
      ],
      length(var.assume_role_arns) > 0 ? [
        {
          Effect : "Allow",
          Principal : {
            "AWS": var.assume_role_arns
          },
          Action : "sts:AssumeRole"
        }
      ] : []
    )
  })
  tags = merge({
    repo = each.key
  }, var.tags)
}

locals {
  policy_mapping = flatten([
    for repo in var.github_repos: [
      for key, policy in var.iam_policy_arns : {
        repo = repo
        policy = policy
        key = "${repo}-${key}"
      }
    ]
  ])
}

resource aws_iam_role_policy_attachment gh_repo_policy_attachment {
  for_each = {
    for mapping in local.policy_mapping : mapping.key => mapping
  }
  role       = aws_iam_role.gh_repo_role[each.value.repo].name
  policy_arn = each.value.policy
}

resource github_actions_variable gh_role_arn_var {
  for_each = var.github_repo_arn_var_name == null ? {} : {for repo in var.github_repos : repo => repo}
  repository = split("/", each.key)[1]
  variable_name = var.github_repo_arn_var_name
  value = aws_iam_role.gh_repo_role[each.key].arn
}
