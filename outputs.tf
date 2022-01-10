output "user_key_id" {
  value       = aws_iam_access_key.this.id
  description = "User access key"
}

output "user_smtp_password" {
  value       = aws_iam_access_key.this.ses_smtp_password_v4
  description = "User SES SMTP password"
}

output "dkim_pairs" {
  value = [for dkim in aws_route53_record.dkim : {
    name  = dkim.name,
    value = aws_ses_domain_dkim.this.dkim_tokens[index(aws_route53_record.dkim, dkim)]
  }]
  description = "DKIM name-value pairs needed to verify domain"
}

output "domain_identity" {
  value = {
    name  = aws_route53_record.domain_identity.name,
    value = aws_ses_domain_identity.this.verification_token
  }
  description = "Domain name-value pair needed to verify domain"
}

