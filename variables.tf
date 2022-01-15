variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "domain_name" {
  type        = string
  description = "The domain name from which AWS SES will be able to send emails."
}

variable "email_addresses" {
  type        = set(string)
  default     = []
  description = "Emails from which AWS SES will be able to send emails."
}
