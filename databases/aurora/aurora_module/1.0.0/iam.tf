#================ IAM Configurations ===================
resource "aws_iam_role" "rds_iamrole_lambda" {
  name                = local.rdslambda_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.lambda_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSLambda_FullAccess", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess", aws_iam_policy.iampolicy_custom.arn]
  tags                = merge(local.tags, { Name : local.rdslambda_iamrole_name })
}

resource "aws_iam_role" "rds_iamrole_enhancedmonitoring" {
  name                = local.rdsenhancedmonitoring_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.rdsmonitoring_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
  tags                = merge(local.tags, { Name : local.rdsenhancedmonitoring_iamrole_name })
}

resource "aws_iam_policy" "iampolicy_custom" {
  name   = local.custom_iampolicy_name
  policy = data.template_file.iam_custompolicy.rendered
  tags   = merge(local.tags, { Name : local.rdslambda_iampolicy_name })
}
#================ End of IAM Configurations ============