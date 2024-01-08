## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.docdb_cluster_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.docdb_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.docdb_parametergroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_event_subscription.docdb_cluster_clustereventsubscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_event_subscription) | resource |
| [aws_docdb_event_subscription.docdb_cluster_instanceeventsubscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_event_subscription) | resource |
| [aws_docdb_subnet_group.docdb_subnetgroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_kms_alias.docdb_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.docdb_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.docdb_kms_keypolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_route53_record.docdb_route53_cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.docdb_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.docdb_secretsmanager_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.docdb_securitygroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.docdb_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.docdb_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.docdb_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [random_password.docdb_secretsmanager_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.docdb_route53_hostedzoneid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret_version.docdb_admin_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.docdb_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.docdb_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_docdb_kms_multiregion"></a> [docdb\_kms\_multiregion](#input\_docdb\_kms\_multiregion) | If true, KMS will be Multi Region rather than Regional. | `bool` | `false` | no |
| <a name="input_docdb_cluster_azs"></a> [docdb\_cluster\_azs](#input\_docdb\_cluster\_azs) | The DocumentDB's cluster AZs. | `list(any)` | `null` | no |
| <a name="input_docdb_sns_subscriptionendpoints"></a> [docdb\_sns\_subscriptionendpoints](#input\_docdb\_sns\_subscriptionendpoints) | The SNS topic subscription's endpoints. This works for multiple email address values. | `list(any)` | `[]` | no |
| <a name="input_docdb_subnetgroup_subnets"></a> [docdb\_subnetgroup\_subnets](#input\_docdb\_subnetgroup\_subnets) | The Subnet Groups's subnets. This works for multiple subnet id values. | `list(any)` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to all resources. | `map(string)` | <pre>{<br>  "module_owner": "srepod8",<br>  "terraform": "yes"<br>}</pre> | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_docdb_cluster_engine"></a> [docdb\_cluster\_engine](#input\_docdb\_cluster\_engine) | The DocumentDB engine type. Valid value is docdb. | `string` | `"docdb"` | no |
| <a name="input_docdb_cluster_engineversion"></a> [docdb\_cluster\_engineversion](#input\_docdb\_cluster\_engineversion) | The DocumentDB's version. Valid values are 3.6.0 or 4.0.0 or 5.0.0. | `string` | `"4.0.0"` | no |
| <a name="input_docdb_cluster_instanceclass"></a> [docdb\_cluster\_instanceclass](#input\_docdb\_cluster\_instanceclass) | The DocumentDB's instance class. Valid values are db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge. | `string` | `"db.t3.medium"` | no |
| <a name="input_docdb_cluster_name"></a> [docdb\_cluster\_name](#input\_docdb\_cluster\_name) | The DocumentDB's cluster name. The first character must be a letter. Example: tpi | `string` | `null` | no |
| <a name="input_docdb_database_name"></a> [docdb\_database\_name](#input\_docdb\_database\_name) | The DocumentDB's database name. | `string` | n/a | yes |
| <a name="input_docdb_parametergroupcluster_file"></a> [docdb\_parametergroupcluster\_file](#input\_docdb\_parametergroupcluster\_file) | Config file name of the DocumentDB's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: docdb\_parametergroup\_cluster.json | `string` | `null` | no |
| <a name="input_docdb_route53_hostedzoneid"></a> [docdb\_route53\_hostedzoneid](#input\_docdb\_route53\_hostedzoneid) | The Hosted zone ID. Example: Z0270985K4K59VI2QMIK | `string` | n/a | yes |
| <a name="input_docdb_securitygroup_vpcid"></a> [docdb\_securitygroup\_vpcid](#input\_docdb\_securitygroup\_vpcid) | VPC id where the DocumentDB will be deployed. | `string` | n/a | yes |
| <a name="input_docdb_sns_subscriptionprotocol"></a> [docdb\_sns\_subscriptionprotocol](#input\_docdb\_sns\_subscriptionprotocol) | The SNS topic subscription's Protocol. Valid values are email or email-json. | `string` | `"email"` | no |
| <a name="input_iam_customepolicy_file"></a> [iam\_customepolicy\_file](#input\_iam\_customepolicy\_file) | Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder. | `string` | `"iam_custompolicy.json"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docdb_cluster_arn"></a> [docdb\_cluster\_arn](#output\_docdb\_cluster\_arn) | ARN of the DocumentDB cluster. |
| <a name="output_docdb_cluster_endpoint"></a> [docdb\_cluster\_endpoint](#output\_docdb\_cluster\_endpoint) | Ednpoint of the DocumentDB cluster. |
| <a name="output_docdb_cluster_identifier"></a> [docdb\_cluster\_identifier](#output\_docdb\_cluster\_identifier) | Name of the DocumentDB cluster. |
| <a name="output_docdb_cluster_instances"></a> [docdb\_cluster\_instances](#output\_docdb\_cluster\_instances) | Instances of the DocumentDB cluster. |
| <a name="output_docdb_cluster_resourceid"></a> [docdb\_cluster\_resourceid](#output\_docdb\_cluster\_resourceid) | Resource ID of the DocumentDB cluster. |
| <a name="output_docdb_kms_alias"></a> [docdb\_kms\_alias](#output\_docdb\_kms\_alias) | Alias of the DocumentDB KMS. |
| <a name="output_docdb_kms_arn"></a> [docdb\_kms\_arn](#output\_docdb\_kms\_arn) | ARN of the DocumentDB KMS. |
| <a name="output_docdb_parametergroup_clusterfamily"></a> [docdb\_parametergroup\_clusterfamily](#output\_docdb\_parametergroup\_clusterfamily) | Family of the DocumentDB ParameterGroup cluster. |
| <a name="output_docdb_parametergroup_clustername"></a> [docdb\_parametergroup\_clustername](#output\_docdb\_parametergroup\_clustername) | Name of the DocumentDB ParameterGroup cluster. |
| <a name="output_docdb_route53_writerendpoint"></a> [docdb\_route53\_writerendpoint](#output\_docdb\_route53\_writerendpoint) | Writer edpoint for the DocumentDB cluster. |
| <a name="output_docdb_secretsmanager_arn"></a> [docdb\_secretsmanager\_arn](#output\_docdb\_secretsmanager\_arn) | ARN of the DocumentDB Secret. |
| <a name="output_docdb_secretsmanager_name"></a> [docdb\_secretsmanager\_name](#output\_docdb\_secretsmanager\_name) | Name of the DocumentDB Secret. |
| <a name="output_docdb_securitygroup_id"></a> [docdb\_securitygroup\_id](#output\_docdb\_securitygroup\_id) | ID of the DocumentDB SecurityGroup. |
| <a name="output_docdb_securitygroup_name"></a> [docdb\_securitygroup\_name](#output\_docdb\_securitygroup\_name) | Name of the DocumentDB SecurityGroup. |
| <a name="output_docdb_securitygroup_vpcid"></a> [docdb\_securitygroup\_vpcid](#output\_docdb\_securitygroup\_vpcid) | VPC of the DocumentDB SecurityGroup. |
| <a name="output_docdb_sns_arn"></a> [docdb\_sns\_arn](#output\_docdb\_sns\_arn) | ARN of the DocumentDB Secret. |
| <a name="output_docdb_sns_name"></a> [docdb\_sns\_name](#output\_docdb\_sns\_name) | Name of the DocumentDB Secret. |
| <a name="output_docdb_subnetgroup_name"></a> [docdb\_subnetgroup\_name](#output\_docdb\_subnetgroup\_name) | Name of the DocumentDB subnetgroup. |
| <a name="output_docdb_subnetgroup_subnets"></a> [docdb\_subnetgroup\_subnets](#output\_docdb\_subnetgroup\_subnets) | Subnets of the DocumentDB subnetgroup. |
