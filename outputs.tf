output "dkim_verification_attrs" {
  value = [for dkim in aws_ses_domain_dkim.this.dkim_tokens : {
    name  = "${dkim}._domainkey.${var.domain_name}"
    type  = "CNAME"
    value = "${dkim}.dkim.amazonses.com"
  }]
  description = "DKIM name, value, type attributes needed to verify domain"
}

output "domain_identity_verification_attrs" {
  value = [
    {
      name  = "_amazonses.${var.domain_name}"
      type  = "TXT"
      value = aws_ses_domain_identity.this.verification_token
    }
  ]
  description = "Domain identity name, value, type attributes needed to verify domain"
}

output "send_email_policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "IAM policy ARN for sending emails"
}
