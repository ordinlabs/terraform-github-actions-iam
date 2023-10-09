output github_repo_role_arns {
  value = {for name, role in aws_iam_role.gh_repo_role : name => role.arn}
}
