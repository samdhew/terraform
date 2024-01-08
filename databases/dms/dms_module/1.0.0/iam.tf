#================ IAM Configurations ===================
resource "aws_iam_role" "dms_iamrole_accessendpoint" {
  name                = local.dmsaccessendpoint_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.dms_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSRedshiftS3Role"]
  tags                = merge(local.tags, { Name : local.dmsaccessendpoint_iamrole_name })
}

resource "aws_iam_role" "dms_iamrole_cwlogs" {
  name                = local.dmscwlogs_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.dms_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"]
  tags                = merge(local.tags, { Name : local.dmscwlogs_iamrole_name })
}

resource "aws_iam_role" "dms_iamrole_vpc" {
  name                = local.dmsvpc_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.dms_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"]
  tags                = merge(local.tags, { Name : local.dmsvpc_iamrole_name })
}

# resource "aws_iam_policy" "iampolicy_custom" {
#   name   = local.custom_iampolicy_name
#   policy = data.template_file.iam_custompolicy.rendered
#   tags   = merge(local.tags, { Name : local.dmslambda_iampolicy_name })
# }
#================ End of IAM Configurations ============