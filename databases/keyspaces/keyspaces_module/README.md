## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.iampolicy_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.keyspaces_iamrole_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_keyspaces_keyspace.keyspaces_keyspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/keyspaces_keyspace) | resource |
| [aws_keyspaces_table.keyspaces_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/keyspaces_table) | resource |
| [aws_kms_alias.keyspaces_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.keyspaces_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.keyspaces_kms_keypolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_sns_topic.keyspaces_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.keyspaces_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.keyspaces_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ec2_assumerole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.keyspaces_route53_hostedzoneid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [template_file.iam_custompolicy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keyspaces_kms_multiregion"></a> [keyspaces\_kms\_multiregion](#input\_keyspaces\_kms\_multiregion) | If true, KMS will be Multi Region rather than Regional. | `bool` | `false` | no |
| <a name="input_keyspaces_sns_subscriptionendpoints"></a> [keyspaces\_sns\_subscriptionendpoints](#input\_keyspaces\_sns\_subscriptionendpoints) | The SNS topic subscription's endpoints. This works for multiple email address values. | `list(any)` | `[]` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to all resources. | `map(string)` | <pre>{<br>  "module_owner": "srepod8",<br>  "terraform": "yes"<br>}</pre> | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_keyspaces_table_readcapacity"></a> [keyspaces\_table\_readcapacity](#input\_keyspaces\_table\_readcapacity) | The Keyspaces's table read capacity units. | `number` | `0` | no |
| <a name="input_keyspaces_table_ttldefault"></a> [keyspaces\_table\_ttldefault](#input\_keyspaces\_table\_ttldefault) | The Keyspaces's table default ttl value. This is in seconds. | `number` | `0` | no |
| <a name="input_keyspaces_table_writecapacity"></a> [keyspaces\_table\_writecapacity](#input\_keyspaces\_table\_writecapacity) | The Keyspaces's table write capacity units. | `number` | `0` | no |
| <a name="input_iam_customepolicy_file"></a> [iam\_customepolicy\_file](#input\_iam\_customepolicy\_file) | Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder. | `string` | `"iam_custompolicy.json"` | no |
| <a name="input_keyspaces_keyspace_name"></a> [keyspaces\_keyspace\_name](#input\_keyspaces\_keyspace\_name) | The Keyspaces's Keyspace name. The first character must be a letter. Example: gradebook | `string` | n/a | yes |
| <a name="input_keyspaces_route53_hostedzoneid"></a> [keyspaces\_route53\_hostedzoneid](#input\_keyspaces\_route53\_hostedzoneid) | The Hosted zone ID. Example: Z0270985K4K59VI2QMIK | `string` | n/a | yes |
| <a name="input_keyspaces_sns_subscriptionprotocol"></a> [keyspaces\_sns\_subscriptionprotocol](#input\_keyspaces\_sns\_subscriptionprotocol) | The SNS topic subscription's Protocol. Valid values are email or email-json. | `string` | `"email"` | no |
| <a name="input_keyspaces_table_clientsidetimestamps"></a> [keyspaces\_table\_clientsidetimestamps](#input\_keyspaces\_table\_clientsidetimestamps) | The Keyspaces's table client side timestamps status. Valid values are ENABLED or DISABLED. | `string` | `"DISABLED"` | no |
| <a name="input_keyspaces_table_description"></a> [keyspaces\_table\_description](#input\_keyspaces\_table\_description) | The Keyspaces's table description. | `string` | `null` | no |
| <a name="input_keyspaces_table_name"></a> [keyspaces\_table\_name](#input\_keyspaces\_table\_name) | The Keyspaces's table name. The first character must be a letter. Example: itembyprovider | `string` | n/a | yes |
| <a name="input_keyspaces_table_pointintimerecovery"></a> [keyspaces\_table\_pointintimerecovery](#input\_keyspaces\_table\_pointintimerecovery) | The Keyspaces's table point in time recovery status. Valid values are ENABLED or DISABLED. | `string` | `"DISABLED"` | no |
| <a name="input_keyspaces_table_throughputmode"></a> [keyspaces\_table\_throughputmode](#input\_keyspaces\_table\_throughputmode) | The Keyspaces's table throughput mode. Valid values are PAY\_PER\_REQUEST or PROVISIONED. | `string` | `"PAY_PER_REQUEST"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keyspaces_keyspace_arn"></a> [keyspaces\_keyspace\_arn](#output\_keyspaces\_keyspace\_arn) | ARN of the Keyspaces Keyspace. |
| <a name="output_keyspaces_keyspace_name"></a> [keyspaces\_keyspace\_name](#output\_keyspaces\_keyspace\_name) | Name of the Keyspaces Keyspace. |
| <a name="output_keyspaces_kms_alias"></a> [keyspaces\_kms\_alias](#output\_keyspaces\_kms\_alias) | Alias of the Keyspaces KMS. |
| <a name="output_keyspaces_kms_arn"></a> [keyspaces\_kms\_arn](#output\_keyspaces\_kms\_arn) | ARN of the Keyspaces KMS. |
| <a name="output_keyspaces_sns_arn"></a> [keyspaces\_sns\_arn](#output\_keyspaces\_sns\_arn) | ARN of the Keyspaces Secret. |
| <a name="output_keyspaces_sns_name"></a> [keyspaces\_sns\_name](#output\_keyspaces\_sns\_name) | Name of the Keyspaces Secret. |
