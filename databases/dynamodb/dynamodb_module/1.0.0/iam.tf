#================ IAM Configurations ===================
resource "aws_iam_role" "dynamodb_iamrole_ec2" {
  name                = local.dynamodbec2_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.ec2_assumerole_policy.json
  managed_policy_arns = [aws_iam_policy.iampolicy_custom.arn]
  depends_on          = [aws_dynamodb_keyspace.dynamodb_keyspace]
  tags                = merge(local.tags, { Name : local.dynamodbec2_iamrole_name })
}

resource "aws_iam_policy" "iampolicy_custom" {
  name   = local.custom_iampolicy_name
  policy = templatefile("TFCustomResourceConfigs/${var.iam_customepolicy_file}", { account_id = local.account_id, dynamodb_keyspace_name = aws_dynamodb_keyspace.dynamodb_keyspace.name })
  tags   = merge(local.tags, { Name : local.dynamodbec2_iampolicy_name })
}
#================ End of IAM Configurations ============