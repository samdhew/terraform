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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.elasticache_loggroup_engine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.elasticache_loggroup_slow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_cluster.elasticache_cluster_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.elasticache_parametergroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.elasticache_replicationgroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.elasticache_subnetgroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_elasticache_user.elasticache_user_readappuser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user.elasticache_user_redisadmin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user.elasticache_user_writeappuser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user_group.elasticache_usergroup_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group) | resource |
| [aws_elasticache_user_group.elasticache_usergroup_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group) | resource |
| [aws_elasticache_user_group_association.elasticache_usergroupassociation_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group_association) | resource |
| [aws_elasticache_user_group_association.elasticache_usergroupassociation_readappuser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group_association) | resource |
| [aws_elasticache_user_group_association.elasticache_usergroupassociation_writeappuser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group_association) | resource |
| [aws_kms_alias.elasticache_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.elasticache_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.elasticache_kms_keypolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_route53_record.elasticache_route53_cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.elasticache_secretsmanager_appsecret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.elasticache_secretsmanager_adminnewversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.elasticache_secretsmanager_adminoldversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.elasticache_secretsmanager_appnewversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.elasticache_secretsmanager_appoldversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.elasticache_securitygroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.elasticache_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.elasticache_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.elasticache_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [random_password.elasticache_secretsmanager_adminpassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.elasticache_secretsmanager_authpassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.elasticache_secretsmanager_readerpassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.elasticache_secretsmanager_writerpassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.elasticache_route53_hostedzoneid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret_version.elasticache_admin_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.elasticache_app_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.elasticache_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.elasticache_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elasticache_kms_multiregion"></a> [elasticache\_kms\_multiregion](#input\_elasticache\_kms\_multiregion) | If true, KMS will be Multi Region rather than Regional. | `bool` | `false` | no |
| <a name="input_elasticache_cluster_azs"></a> [elasticache\_cluster\_azs](#input\_elasticache\_cluster\_azs) | The Elasticache Memcached/Redis's cluster AZs. | `list(any)` | `null` | no |
| <a name="input_elasticache_sns_subscriptionendpoints"></a> [elasticache\_sns\_subscriptionendpoints](#input\_elasticache\_sns\_subscriptionendpoints) | The SNS topic subscription's endpoints. This works for multiple email address values. | `list(any)` | `[]` | no |
| <a name="input_elasticache_subnetgroup_subnets"></a> [elasticache\_subnetgroup\_subnets](#input\_elasticache\_subnetgroup\_subnets) | The Subnet Groups's subnets. This works for multiple subnet id values. | `list(any)` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to all resources. | `map(string)` | <pre>{<br>  "module_owner": "srepod8",<br>  "terraform": "yes"<br>}</pre> | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_elasticache_cluster_engine"></a> [elasticache\_cluster\_engine](#input\_elasticache\_cluster\_engine) | The Elasticache engine type. Valid values are elasticache-memcached or elasticache-redis. | `string` | n/a | yes |
| <a name="input_elasticache_cluster_engineversion"></a> [elasticache\_cluster\_engineversion](#input\_elasticache\_cluster\_engineversion) | The Elasticache Memcached's valid values are 1.4.34 or 1.5.16 or 1.6.17. The Elasticache Redis's valid values are 4.0.10 or 5.0.6 or 6.2 or 7.0 | `string` | n/a | yes |
| <a name="input_elasticache_cluster_instanceclass"></a> [elasticache\_cluster\_instanceclass](#input\_elasticache\_cluster\_instanceclass) | The Elasticache Memcached/Redis's instance class. Valid values are cache.t3.medium or cache.t4g.medium or cache.r5.large or cache.r5.xlarge or cache.r5.2xlarge or cache.r6g.large or cache.r6g.xlarge or cache.r6g.2xlarge. | `string` | `"cache.t3.medium"` | no |
| <a name="input_elasticache_cluster_name"></a> [elasticache\_cluster\_name](#input\_elasticache\_cluster\_name) | The Elasticache Memcached/Redis's cluster name. The first character must be a letter. Example: tpi | `string` | `null` | no |
| <a name="input_elasticache_parametergroupcluster_file"></a> [elasticache\_parametergroupcluster\_file](#input\_elasticache\_parametergroupcluster\_file) | Config file name of the Elasticache Memcached/Redis's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: redis\_parametergroup\_cluster.json | `string` | `null` | no |
| <a name="input_elasticache_route53_hostedzoneid"></a> [elasticache\_route53\_hostedzoneid](#input\_elasticache\_route53\_hostedzoneid) | The Hosted zone ID. Example: Z0270985K4K59VI2QMIK | `string` | n/a | yes |
| <a name="input_elasticache_securitygroup_vpcid"></a> [elasticache\_securitygroup\_vpcid](#input\_elasticache\_securitygroup\_vpcid) | VPC id where the Elasticache Memcached/Redis will be deployed. | `string` | n/a | yes |
| <a name="input_elasticache_sns_subscriptionprotocol"></a> [elasticache\_sns\_subscriptionprotocol](#input\_elasticache\_sns\_subscriptionprotocol) | The SNS topic subscription's Protocol. Valid values are email or email-json. | `string` | `"email"` | no |
| <a name="input_iam_customepolicy_file"></a> [iam\_customepolicy\_file](#input\_iam\_customepolicy\_file) | Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder. | `string` | `"iam_custompolicy.json"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticache_cluster_arn"></a> [elasticache\_cluster\_arn](#output\_elasticache\_cluster\_arn) | ARN of the Elasticache Memcached/Redis cluster. |
| <a name="output_elasticache_cluster_endpoint"></a> [elasticache\_cluster\_endpoint](#output\_elasticache\_cluster\_endpoint) | Ednpoint of the Elasticache Memcached/Redis cluster. |
| <a name="output_elasticache_cluster_identifier"></a> [elasticache\_cluster\_identifier](#output\_elasticache\_cluster\_identifier) | Name of the Elasticache Memcached/Redis cluster. |
| <a name="output_elasticache_cluster_instances"></a> [elasticache\_cluster\_instances](#output\_elasticache\_cluster\_instances) | Instances of the Elasticache Memcached/Redis cluster. |
| <a name="output_elasticache_kms_alias"></a> [elasticache\_kms\_alias](#output\_elasticache\_kms\_alias) | Alias of the Elasticache Memcached/Redis KMS. |
| <a name="output_elasticache_kms_arn"></a> [elasticache\_kms\_arn](#output\_elasticache\_kms\_arn) | ARN of the Elasticache Memcached/Redis KMS. |
| <a name="output_elasticache_parametergroup_clusterfamily"></a> [elasticache\_parametergroup\_clusterfamily](#output\_elasticache\_parametergroup\_clusterfamily) | Family of the Elasticache Memcached/Redis ParameterGroup cluster. |
| <a name="output_elasticache_parametergroup_clustername"></a> [elasticache\_parametergroup\_clustername](#output\_elasticache\_parametergroup\_clustername) | Name of the Elasticache Memcached/Redis ParameterGroup cluster. |
| <a name="output_elasticache_route53_writerendpoint"></a> [elasticache\_route53\_writerendpoint](#output\_elasticache\_route53\_writerendpoint) | Writer edpoint for the Elasticache Memcached/Redis cluster. |
| <a name="output_elasticache_secretsmanager_adminarn"></a> [elasticache\_secretsmanager\_adminarn](#output\_elasticache\_secretsmanager\_adminarn) | ARN of the Elasticache Memcached/Redis Admin Secret. |
| <a name="output_elasticache_secretsmanager_adminname"></a> [elasticache\_secretsmanager\_adminname](#output\_elasticache\_secretsmanager\_adminname) | Name of the Elasticache Memcached/Redis Admin Secret. |
| <a name="output_elasticache_secretsmanager_apparn"></a> [elasticache\_secretsmanager\_apparn](#output\_elasticache\_secretsmanager\_apparn) | ARN of the Elasticache Memcached/Redis App Secret. |
| <a name="output_elasticache_secretsmanager_appname"></a> [elasticache\_secretsmanager\_appname](#output\_elasticache\_secretsmanager\_appname) | Name of the Elasticache Memcached/Redis App Secret. |
| <a name="output_elasticache_securitygroup_id"></a> [elasticache\_securitygroup\_id](#output\_elasticache\_securitygroup\_id) | ID of the Elasticache Memcached/Redis SecurityGroup. |
| <a name="output_elasticache_securitygroup_name"></a> [elasticache\_securitygroup\_name](#output\_elasticache\_securitygroup\_name) | Name of the Elasticache Memcached/Redis SecurityGroup. |
| <a name="output_elasticache_securitygroup_vpcid"></a> [elasticache\_securitygroup\_vpcid](#output\_elasticache\_securitygroup\_vpcid) | VPC of the Elasticache Memcached/Redis SecurityGroup. |
| <a name="output_elasticache_sns_arn"></a> [elasticache\_sns\_arn](#output\_elasticache\_sns\_arn) | ARN of the Elasticache Memcached/Redis Secret. |
| <a name="output_elasticache_sns_name"></a> [elasticache\_sns\_name](#output\_elasticache\_sns\_name) | Name of the Elasticache Memcached/Redis Secret. |
| <a name="output_elasticache_subnetgroup_name"></a> [elasticache\_subnetgroup\_name](#output\_elasticache\_subnetgroup\_name) | Name of the Elasticache Memcached/Redis subnetgroup. |
| <a name="output_elasticache_subnetgroup_subnets"></a> [elasticache\_subnetgroup\_subnets](#output\_elasticache\_subnetgroup\_subnets) | Subnets of the Elasticache Memcached/Redis subnetgroup. |
