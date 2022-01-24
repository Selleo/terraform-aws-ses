# Terraform AWS SES module
See [Changelog](https://github.com/Selleo/terraform-aws-ses/blob/main/CHANGELOG.md) for release information.

## Usage
```tf
module "ses" {
  source          = "Selleo/ses/aws"
  email_addresses = ["info@example.com", "office@example.com"]
  domain_name     = "example.com
  name_prefix     = "exmpale-com"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ses_email_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_ses_domain_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_dkim.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix that will be prepended to resource names | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name from which AWS SES will be able to send emails. | `string` | n/a | yes |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email_\addresses) | Emails from which AWS SES will be able to send emails. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dkim_verification_attrs"></a> [dkim\_verification\_attrs](#output\_dkim\_verification\_attrs) | DKIM name, value, type attributes needed to verify domain |
| <a name="output_domain_identity_verification_attrs"></a> [domain\_identity\_verification\_attrs](#output\_domain\_identity\_verification\_attrs) | Domain identity name, value, type attributes needed to verify domain |
| <a name="output_send_email_policy_arn"></a> [send\_email\_policy\_arn](#output\_send\_email\_policy\_arn) | IAM policy ARN for sending emails |

## Maintainers

* Mateusz Wieczorek ([@mateuszwu](https://github.com/mateuszwu))

## LICENSE

See `LICENSE` file.

## About Selleo

![selleo](https://raw.githubusercontent.com/Selleo/selleo-resources/master/public/github_footer.png)

Software development teams with an entrepreneurial sense of ownership at their core delivering great digital products and building culture people want to belong to. We are a community of engaged co-workers passionate about crafting impactful web solutions which transform the way our clients do business.

All names and logos for [Selleo](https://selleo.com/about) are trademark of Selleo Labs Sp. z o.o. (formerly Selleo Sp. z o.o. Sp.k.)
