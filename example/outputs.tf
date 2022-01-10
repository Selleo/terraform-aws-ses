output "user_key_id" {
  value = module.ses.user_key_id
}

output "user_secret" {
  value     = module.ses.user_smtp_password
  sensitive = true
}

output "dkim_pairs" {
  value = module.ses.dkim_pairs
}

output "domain_identity" {
  value = module.ses.domain_identity
}
