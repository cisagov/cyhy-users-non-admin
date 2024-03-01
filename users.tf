# The non-admin users being created
resource "aws_iam_user" "users" {
  for_each = toset(keys(var.users))

  name = each.value
}

# Attach the self-administration (with MFA required) policy to each user
# where self_managed is true and require_mfa is true
resource "aws_iam_user_policy_attachment" "self_managed_creds_with_mfa" {
  # Ensure that the user exists before attempting to attach the
  # policy.  Ideally the depends_on could live inside the scope of the
  # for_each, so that we could depend only on the specific user that
  # this policy attachment references, but that is not possible;
  # hence, we must depend on _all_ users.  The effect is the same,
  # although getting there is less efficient since _all_ the users are
  # created before _any_ policy attachments.
  depends_on = [aws_iam_user.users]

  for_each = { for k, v in var.users : k => v if v["self_managed"] && v["require_mfa"] }

  user       = each.key
  policy_arn = var.self_managed_creds_with_mfa_policy_arn
}

# Attach the self-administration (without MFA required) policy to each user
# where self_managed is true and require_mfa is false
resource "aws_iam_user_policy_attachment" "self_managed_creds_without_mfa" {
  # Ensure that the user exists before attempting to attach the
  # policy.  Ideally the depends_on could live inside the scope of the
  # for_each, so that we could depend only on the specific user that
  # this policy attachment references, but that is not possible;
  # hence, we must depend on _all_ users.  The end result is the same,
  # although getting there is less efficient since _all_ the users are
  # created before _any_ policy attachments.
  depends_on = [aws_iam_user.users]

  for_each = { for k, v in var.users : k => v if v["self_managed"] && !v["require_mfa"] }

  user       = each.key
  policy_arn = var.self_managed_creds_without_mfa_policy_arn
}
