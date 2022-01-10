# Email Identities
resource "aws_ses_email_identity" "this" {
  for_each = var.email_addresses
  email    = each.key
}

# Domain Identity with Route53 validatation
resource "aws_ses_domain_identity" "this" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

data "aws_route53_zone" "this" {
  name         = aws_ses_domain_identity.this.domain
  private_zone = false
}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "domain_identity" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.this.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

resource "aws_ses_domain_identity_verification" "this" {
  domain = aws_ses_domain_identity.this.id

  depends_on = [aws_route53_record.domain_identity]
}

# User with access policy for Email Identities and Domain Identity
data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail",
    ]

    resources = flatten(
      [[for email in aws_ses_email_identity.this : email.arn], aws_ses_domain_identity.this.arn],
    )
  }
}

resource "aws_iam_user" "this" {
  name = "ses-send-email"
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_policy" "this" {
  name   = "aws-iam-ses-send-email"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
