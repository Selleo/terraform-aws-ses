module "ses" {
  source          = "../"
  email_addresses = ["info@example.com", "office@example.com"]
  domain_name     = "my_domain.com"
}
