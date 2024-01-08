#================ KMS Configurations ===================
resource "aws_kms_key" "ec2database_kms_key" {
  description              = local.ec2database_kms_name
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled               = true
  enable_key_rotation      = true
  multi_region             = var.ec2database_kms_multiregion
  tags                     = merge(local.tags, { Name : local.ec2database_kms_name })
}

resource "aws_kms_alias" "ec2database_kms_alias" {
  target_key_id = aws_kms_key.ec2database_kms_key.key_id
  name          = "alias/${local.ec2database_kms_name}"
}

resource "aws_kms_key_policy" "ec2database_kms_keypolicy" {
  key_id = aws_kms_key.ec2database_kms_key.key_id
  policy = jsonencode({
    "Id" = "ec2database_kms_keypolicy",
    "Statement" = [
      {
        "Action" = "kms:*",
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:root"
        },
        "Resource" = "*",
        "Sid"      = "Enable IAM User Permissions"
      },
      {
        "Action" = ["kms:Create*", "kms:Describe*", "kms:Enable*", "kms:List*", "kms:Put*", "kms:Update*", "kms:Revoke*", "kms:Disable*", "kms:Get*", "kms:Delete*", "kms:TagResource", "kms:UntagResource", "kms:ScheduleKeyDeletion", "kms:CancelKeyDeletion"],
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Resource" = "*",
        "Sid"      = "Allow access for Key Administrators"
      },
      {
        "Action" = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey"],
        "Effect" = "Allow",
        "Principal" = {
          "Service" = [
            "cloudwatch.amazonaws.com",
            "logs.us-east-1.amazonaws.com",
            "migrationhub.amazonaws.com",
            "dms.amazonaws.com"
          ],
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Resource" = "*",
        "Sid"      = "Allow use of the key"
      },
      {
        "Action" = ["kms:CreateGrant", "kms:ListGrants", "kms:RevokeGrant"],
        "Condition" = {
          "Bool" = {
            "kms:GrantIsForAWSResource" = "true"
          }
        },
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Resource" = "*",
        "Sid"      = "Allow attachment of persistent resources"
      }
    ],
    "Version" = "2012-10-17"
  })
}
#================ End of KMS Configurations ============