#================ SNS Configurations ===================
resource "aws_sns_topic" "dms_sns_topic" {
  name              = local.dms_sns_name
  display_name      = local.dms_sns_name
  kms_master_key_id = aws_kms_key.dms_kms_key.arn
  tags              = merge(local.tags, { Name : local.dms_sns_name })
}

resource "aws_sns_topic_policy" "dms_sns_policy" {
  arn = aws_sns_topic.dms_sns_topic.arn
  policy = jsonencode({
    "Id" = "dms_secretsmanager_secretpolicy",
    "Statement" = [
      {
        "Sid"    = "EnforceHttpsOnPublish",
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Action"   = "sns:Publish",
        "Resource" = aws_sns_topic.dms_sns_topic.arn,
        "Condition" = {
          "Bool" = {
            "aws:SecureTransport" = "true"
          }
        }
      },
      {
        "Sid"    = "RoleToSubscribe",
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Action"   = "sns:Subscribe",
        "Resource" = aws_sns_topic.dms_sns_topic.arn
      },
      {
        "Sid"    = "EventNotification",
        "Effect" = "Allow",
        "Principal" = {
          "Service" = "s3.amazonaws.com"
        },
        "Action"   = "sns:Publish",
        "Resource" = aws_sns_topic.dms_sns_topic.arn,
        "Condition" = {
          "ArnLike" = {
            "aws:SourceArn" = "arn:aws:s3:::tf-lambda-testing"
          }
        }
      },
      {
        "Sid"    = "AllowPublishAlarms",
        "Effect" = "Allow",
        "Principal" = {
          "Service" = "cloudwatch.amazonaws.com"
        },
        "Action"   = "sns:Publish",
        "Resource" = aws_sns_topic.dms_sns_topic.arn
      }
    ],
    "Version" = "2008-10-17"
  })
}

resource "aws_sns_topic_subscription" "dms_sns_subscription" {
  for_each  = toset(var.dms_sns_subscriptionendpoints)
  protocol  = var.dms_sns_subscriptionprotocol
  endpoint  = each.value
  topic_arn = aws_sns_topic.dms_sns_topic.arn
}
#================ End of SNS Configurations ============