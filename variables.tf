variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "domain_name" {
  type        = string
  description = "The domain name from which AWS SES will be able to send emails."
}

# optional

variable "email_addresses" {
  type        = set(string)
  default     = []
  description = "Emails from which AWS SES will be able to send emails."
}

variable "zone_id" {
  type        = string
  description = "The Route53 zone ID for the domain name."
  default     = ""
}

variable "verify_dkim" {
  type        = bool
  description = "Automatically verify DKIM records in Route53."
  default     = false
}
