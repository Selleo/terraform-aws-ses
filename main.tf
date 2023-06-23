locals {
  dkim_verification_attrs = [for dkim in aws_ses_domain_dkim.this.dkim_tokens : {
    name  = "${dkim}._domainkey.${var.domain_name}"
    ttl   = 600
    type  = "CNAME"
    value = "${dkim}.dkim.amazonses.com"
  }]
}

resource "aws_ses_email_identity" "this" {
  for_each = var.email_addresses
  email    = each.key
}

resource "aws_ses_domain_identity" "this" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

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

resource "aws_iam_policy" "this" {
  name   = "${var.name_prefix}-ses-send-email"
  policy = data.aws_iam_policy_document.this.json
}


resource "aws_route53_record" "this_verify_dkim" {
  count = var.zone_id != "" && var.verify_dkim ? length(local.dkim_verification_attrs) : 0

  zone_id = var.zone_id
  name    = local.dkim_verification_attrs[count.index].name
  type    = local.dkim_verification_attrs[count.index].type
  ttl     = local.dkim_verification_attrs[count.index].ttl
  records = [local.dkim_verification_attrs[count.index].value]
}
