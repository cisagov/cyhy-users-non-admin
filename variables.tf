# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users" {
  description = "A map whose keys are the usernames of each non-admin user and whose values are a map containing supported user attributes. The currently-supported attributes are \"require_mfa\" (boolean) and \"self_managed\" (boolean). Example: { \"firstname1.lastname1\" = { \"require_mfa\" = false, \"self_managed\" = true }, \"firstname2.lastname2\" = { \"require_mfa\" = true, \"self_managed\" = true }, \"firstname3.lastname3\" = { \"require_mfa\" = false, \"self_managed\" = true }, \"service-account1\" = { \"require_mfa\" = false, \"self_managed\" = false } }"
  type        = map(object({ require_mfa = bool, self_managed = bool }))
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "self_managed_creds_with_mfa_policy_description" {
  default     = "Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_with_mfa_policy_name" {
  default     = "SelfManagedCredsWithMFA"
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_without_mfa_policy_description" {
  default     = "Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_without_mfa_policy_name" {
  default     = "SelfManagedCredsWithoutMFA"
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
