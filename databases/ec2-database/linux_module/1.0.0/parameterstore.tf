#================ ParameterStore Configurations ===================
resource "aws_ssm_parameter" "ec2database_parameterstore_parametersshkey" {
  name        = local.ec2database_parametersshkey_name
  description = local.ec2database_parametersshkey_name
  key_id      = aws_kms_key.ec2database_kms_key.arn
  tier        = "Standard"
  data_type   = "text"
  type        = "SecureString"
  value       = tls_private_key.ec2database_privatekey_rsa4096.private_key_openssh
  tags        = merge(local.tags, { Name : local.ec2database_parametersshkey_name })
}
#================ End of ParameterStore Configurations ============