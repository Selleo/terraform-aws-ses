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
