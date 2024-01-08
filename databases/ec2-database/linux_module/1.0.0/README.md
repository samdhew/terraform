## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ec2database_loggroup_engine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_instance_profile.ec2database_iaminstanceprofile_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ec2database_iampolicy_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2database_iamrole_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.ec2database_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ec2database_privatekey](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_kms_alias.ec2database_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ec2database_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.ec2database_kms_keypolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_secretsmanager_secret.ec2database_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.ec2database_secretsmanager_oldversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.ec2database_securitygroup_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.ec2database_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.ec2database_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.ec2database_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [local_sensitive_file.ec2database_privatekey](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [tls_private_key.ec2database_privatekey_rsa4096](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ec2database_ami_pcmubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ec2database_assumerole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_secret_version.ec2database_sshkey_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.ec2database_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.ec2database_subnetgroup_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [template_file.ec2database_iam_custompolicy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2database_kms_multiregion"></a> [ec2database\_kms\_multiregion](#input\_ec2database\_kms\_multiregion) | If true, KMS will be Multi Region rather than Regional. | `bool` | `false` | no |
| <a name="input_ec2database_sns_subscriptionendpoints"></a> [ec2database\_sns\_subscriptionendpoints](#input\_ec2database\_sns\_subscriptionendpoints) | The SNS topic subscription's endpoints. This works for multiple email address values. | `list(any)` | `[]` | no |
| <a name="input_ec2database_subnetgroup_subnets"></a> [ec2database\_subnetgroup\_subnets](#input\_ec2database\_subnetgroup\_subnets) | The EC2 backed database servers' subnets. This works for multiple subnet id values. | `list(any)` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to all resources. | `map(string)` | <pre>{<br>  "module_owner": "srepod8",<br>  "terraform": "yes"<br>}</pre> | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_ec2database_instance_count"></a> [ec2database\_instance\_count](#input\_ec2database\_instance\_count) | The EC2 backed database server count. Servers will be spread across the AZs in | `number` | `1` | no |
| <a name="input_ec2database_instance_cpucores"></a> [ec2database\_instance\_cpucores](#input\_ec2database\_instance\_cpucores) | The EC2 backed database server's CPU cores for vCPUs. Valid values are [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html] and rules in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-cpu-options-rules.html]. | `number` | `1` | no |
| <a name="input_ec2database_instance_threadspercore"></a> [ec2database\_instance\_threadspercore](#input\_ec2database\_instance\_threadspercore) | The EC2 backed database server's CPU cores for vCPUs. Valid values are [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html] and rules in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-cpu-options-rules.html]. | `number` | `2` | no |
| <a name="input_ec2_userdata_file"></a> [ec2\_userdata\_file](#input\_ec2\_userdata\_file) | Userdata file name for the EC2. This file must reside within TFCustomResourceConfigs folder. | `string` | `"ec2_userdata.sh"` | no |
| <a name="input_ec2database_cluster_engine"></a> [ec2database\_cluster\_engine](#input\_ec2database\_cluster\_engine) | The EC2 backed database engine type. Valid values are mysql or postgresql or oracle or sqlserver or mongodb or cassandra. | `string` | n/a | yes |
| <a name="input_ec2database_cluster_instanceclass"></a> [ec2database\_cluster\_instanceclass](#input\_ec2database\_cluster\_instanceclass) | The EC2 backed database server's instance class. Valid values are t3.medium or t4g.medium or r5.large or r5.xlarge or r5.2xlarge or r6g.large or r6g.xlarge or r6g.2xlarge. | `string` | `"t3.medium"` | no |
| <a name="input_ec2database_cluster_name"></a> [ec2database\_cluster\_name](#input\_ec2database\_cluster\_name) | The EC2 backed database server's name. The first character must be a letter. Example: tpi | `string` | `null` | no |
| <a name="input_ec2database_securitygroup_vpcid"></a> [ec2database\_securitygroup\_vpcid](#input\_ec2database\_securitygroup\_vpcid) | VPC id where the Aurora PostgreSQL/MySQL will be deployed. | `string` | n/a | yes |
| <a name="input_ec2database_sns_subscriptionprotocol"></a> [ec2database\_sns\_subscriptionprotocol](#input\_ec2database\_sns\_subscriptionprotocol) | The SNS topic subscription's Protocol. Valid values are email or email-json. | `string` | `"email"` | no |
| <a name="input_iam_customepolicy_file"></a> [iam\_customepolicy\_file](#input\_iam\_customepolicy\_file) | Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder. | `string` | `"iam_custompolicy.json"` | no |

## Outputs

No outputs.
