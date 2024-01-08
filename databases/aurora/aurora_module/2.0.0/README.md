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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_event_subscription.aurora_cluster_clustereventsubscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_event_subscription) | resource |
| [aws_db_event_subscription.aurora_cluster_instanceeventsubscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_event_subscription) | resource |
| [aws_db_parameter_group.aurora_parametergroup_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.aurora_subnetgroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_policy.iampolicy_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rds_iamrole_enhancedmonitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.rds_iamrole_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_alias.aurora_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.aurora_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.aurora_kms_keypolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_rds_cluster.aurora_cluster_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.aurora_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.aurora_parametergroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_route53_record.aurora_route53_cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.aurora_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.aurora_secretsmanager_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.aurora_securitygroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.aurora_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.aurora_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.aurora_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [random_password.aurora_secretsmanager_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_assumerole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.rdsmonitoring_assumerole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.aurora_route53_hostedzoneid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret_version.aurora_admin_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.aurora_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.aurora_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [template_file.iam_custompolicy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aurora_kms_multiregion"></a> [aurora\_kms\_multiregion](#input\_aurora\_kms\_multiregion) | If true, KMS will be Multi Region rather than Regional. | `bool` | `false` | no |
| <a name="input_aurora_cluster_azs"></a> [aurora\_cluster\_azs](#input\_aurora\_cluster\_azs) | The Aurora PostgreSQL/MySQL's cluster AZs. | `list(any)` | `null` | no |
| <a name="input_aurora_sns_subscriptionendpoints"></a> [aurora\_sns\_subscriptionendpoints](#input\_aurora\_sns\_subscriptionendpoints) | The SNS topic subscription's endpoints. This works for multiple email address values. | `list(any)` | `[]` | no |
| <a name="input_aurora_subnetgroup_subnets"></a> [aurora\_subnetgroup\_subnets](#input\_aurora\_subnetgroup\_subnets) | The Subnet Groups's subnets. This works for multiple subnet id values. | `list(any)` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to all resources. | `map(string)` | <pre>{<br>  "module_owner": "srepod8",<br>  "terraform": "yes"<br>}</pre> | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_aurora_cluster_engine"></a> [aurora\_cluster\_engine](#input\_aurora\_cluster\_engine) | The Aurora engine type. Valid values are aurora-mysql or aurora-postgresql or mysql or postgres. | `string` | n/a | yes |
| <a name="input_aurora_cluster_engineversion"></a> [aurora\_cluster\_engineversion](#input\_aurora\_cluster\_engineversion) | The Aurora MySQL's valid values are 2.11.3 or 2.12.0 or 3.01.1 or 3.02.3 or 3.03.1 or 3.04.0. The Aurora PostgreSQL's valid values are 13.11 or 14.8 or 15.3. | `string` | n/a | yes |
| <a name="input_aurora_cluster_instanceclass"></a> [aurora\_cluster\_instanceclass](#input\_aurora\_cluster\_instanceclass) | The Aurora PostgreSQL/MySQL's instance class. Valid values are db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge. | `string` | `"db.t3.medium"` | no |
| <a name="input_aurora_cluster_name"></a> [aurora\_cluster\_name](#input\_aurora\_cluster\_name) | The Aurora PostgreSQL/MySQL's cluster name. The first character must be a letter. Example: tpi | `string` | `null` | no |
| <a name="input_aurora_database_name"></a> [aurora\_database\_name](#input\_aurora\_database\_name) | The Aurora PostgreSQL/MySQL's database name. | `string` | n/a | yes |
| <a name="input_aurora_parametergroupcluster_file"></a> [aurora\_parametergroupcluster\_file](#input\_aurora\_parametergroupcluster\_file) | Config file name of the Aurora PostgreSQL/MySQL's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: aurorapgsql\_parametergroup\_cluster.json | `string` | `null` | no |
| <a name="input_aurora_parametergroupinstance_file"></a> [aurora\_parametergroupinstance\_file](#input\_aurora\_parametergroupinstance\_file) | Config file name of the Aurora PostgreSQL/MySQL's ParameterGroup instance. The config file must be in the TFCustomResourceConfigs folder. Example: aurorapgsql\_parametergroup\_instance.json | `string` | `null` | no |
| <a name="input_aurora_route53_hostedzoneid"></a> [aurora\_route53\_hostedzoneid](#input\_aurora\_route53\_hostedzoneid) | The Hosted zone ID. Example: Z0270985K4K59VI2QMIK | `string` | n/a | yes |
| <a name="input_aurora_securitygroup_vpcid"></a> [aurora\_securitygroup\_vpcid](#input\_aurora\_securitygroup\_vpcid) | VPC id where the Aurora PostgreSQL/MySQL will be deployed. | `string` | n/a | yes |
| <a name="input_aurora_sns_subscriptionprotocol"></a> [aurora\_sns\_subscriptionprotocol](#input\_aurora\_sns\_subscriptionprotocol) | The SNS topic subscription's Protocol. Valid values are email or email-json. | `string` | `"email"` | no |
| <a name="input_iam_customepolicy_file"></a> [iam\_customepolicy\_file](#input\_iam\_customepolicy\_file) | Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder. | `string` | `"iam_custompolicy.json"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_cluster_arn"></a> [aurora\_cluster\_arn](#output\_aurora\_cluster\_arn) | ARN of the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_cluster_endpoint"></a> [aurora\_cluster\_endpoint](#output\_aurora\_cluster\_endpoint) | Endpoint of the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_cluster_identifier"></a> [aurora\_cluster\_identifier](#output\_aurora\_cluster\_identifier) | Name of the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_cluster_instances"></a> [aurora\_cluster\_instances](#output\_aurora\_cluster\_instances) | Instances of the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_cluster_resourceid"></a> [aurora\_cluster\_resourceid](#output\_aurora\_cluster\_resourceid) | Resource ID of the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_database_name"></a> [aurora\_database\_name](#output\_aurora\_database\_name) | Name of the the Aurora PostgreSQL/MySQL's database. |
| <a name="output_aurora_kms_alias"></a> [aurora\_kms\_alias](#output\_aurora\_kms\_alias) | Alias of the Aurora PostgreSQL/MySQL KMS. |
| <a name="output_aurora_kms_arn"></a> [aurora\_kms\_arn](#output\_aurora\_kms\_arn) | ARN of the Aurora PostgreSQL/MySQL KMS. |
| <a name="output_aurora_parametergroup_clusterfamily"></a> [aurora\_parametergroup\_clusterfamily](#output\_aurora\_parametergroup\_clusterfamily) | Family of the Aurora PostgreSQL/MySQL ParameterGroup cluster. |
| <a name="output_aurora_parametergroup_clustername"></a> [aurora\_parametergroup\_clustername](#output\_aurora\_parametergroup\_clustername) | Name of the Aurora PostgreSQL/MySQL ParameterGroup cluster. |
| <a name="output_aurora_parametergroup_instancefamily"></a> [aurora\_parametergroup\_instancefamily](#output\_aurora\_parametergroup\_instancefamily) | Family of the Aurora PostgreSQL/MySQL ParameterGroup instance. |
| <a name="output_aurora_parametergroup_instancename"></a> [aurora\_parametergroup\_instancename](#output\_aurora\_parametergroup\_instancename) | Name of the Aurora PostgreSQL/MySQL ParameterGroup instance. |
| <a name="output_aurora_route53_writerendpoint"></a> [aurora\_route53\_writerendpoint](#output\_aurora\_route53\_writerendpoint) | Writer edpoint for the Aurora PostgreSQL/MySQL cluster. |
| <a name="output_aurora_secretsmanager_arn"></a> [aurora\_secretsmanager\_arn](#output\_aurora\_secretsmanager\_arn) | ARN of the Aurora PostgreSQL/MySQL Secret. |
| <a name="output_aurora_secretsmanager_name"></a> [aurora\_secretsmanager\_name](#output\_aurora\_secretsmanager\_name) | Name of the Aurora PostgreSQL/MySQL Secret. |
| <a name="output_aurora_securitygroup_id"></a> [aurora\_securitygroup\_id](#output\_aurora\_securitygroup\_id) | ID of the Aurora PostgreSQL/MySQL SecurityGroup. |
| <a name="output_aurora_securitygroup_name"></a> [aurora\_securitygroup\_name](#output\_aurora\_securitygroup\_name) | Name of the Aurora PostgreSQL/MySQL SecurityGroup. |
| <a name="output_aurora_securitygroup_vpcid"></a> [aurora\_securitygroup\_vpcid](#output\_aurora\_securitygroup\_vpcid) | VPC of the Aurora PostgreSQL/MySQL SecurityGroup. |
| <a name="output_aurora_sns_arn"></a> [aurora\_sns\_arn](#output\_aurora\_sns\_arn) | ARN of the Aurora PostgreSQL/MySQL Secret. |
| <a name="output_aurora_sns_name"></a> [aurora\_sns\_name](#output\_aurora\_sns\_name) | Name of the Aurora PostgreSQL/MySQL Secret. |
| <a name="output_aurora_subnetgroup_name"></a> [aurora\_subnetgroup\_name](#output\_aurora\_subnetgroup\_name) | Name of the Aurora PostgreSQL/MySQL SubnetGroup. |
| <a name="output_aurora_subnetgroup_subnets"></a> [aurora\_subnetgroup\_subnets](#output\_aurora\_subnetgroup\_subnets) | Subnets of the Aurora PostgreSQL/MySQL SubnetGroup. |
