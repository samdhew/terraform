#================ IAM Configurations ===================
resource "aws_iam_role" "ec2database_iamrole_ec2" {
  name                = local.ec2database_iamrole_name
  assume_role_policy  = data.aws_iam_policy_document.ec2database_assumerole_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess", aws_iam_policy.ec2database_iampolicy_custom.arn]
  tags                = merge(local.tags, { Name : local.ec2database_iamrole_name })
}

resource "aws_iam_policy" "ec2database_iampolicy_custom" {
  name   = local.ec2database_iampolicy_name
  policy = data.template_file.ec2database_iam_custompolicy.rendered
  tags   = merge(local.tags, { Name : local.ec2database_iampolicy_name })
}

resource "aws_iam_instance_profile" "ec2database_iaminstanceprofile_ec2" {
  name = local.ec2database_iaminstanceprofile_name
  role = aws_iam_role.ec2database_iamrole_ec2.name
  tags = merge(local.tags, { Name : local.ec2database_iaminstanceprofile_name })
}
#================ End of IAM Configurations ============