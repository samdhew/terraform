#================ SNS Configurations ===================
resource "aws_sns_topic" "dynamodb_sns_topic" {
  name              = local.dynamodb_sns_name
  display_name      = local.dynamodb_sns_name
  kms_master_key_id = aws_kms_key.dynamodb_kms_key.arn
  tags              = merge(local.tags, { Name : local.dynamodb_sns_name })
}

resource "aws_sns_topic_policy" "dynamodb_sns_policy" {
  arn = aws_sns_topic.dynamodb_sns_topic.arn
  policy = jsonencode({
    "Id" = "dynamodb_secretsmanager_secretpolicy",
    "Statement" = [
      {
        "Sid"    = "EnforceHttpsOnPublish",
        "Effect" = "Allow",
        "Principal" = {
          "AWS" = "arn:aws:iam::${local.account_id}:role/PCMPowerUser"
        },
        "Action"   = "sns:Publish",
        "Resource" = aws_sns_topic.dynamodb_sns_topic.arn,
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
        "Resource" = aws_sns_topic.dynamodb_sns_topic.arn
      },
      {
        "Sid"    = "EventNotification",
        "Effect" = "Allow",
        "Principal" = {
          "Service" = "s3.amazonaws.com"
        },
        "Action"   = "sns:Publish",
        "Resource" = aws_sns_topic.dynamodb_sns_topic.arn,
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
        "Resource" = aws_sns_topic.dynamodb_sns_topic.arn
      }
    ],
    "Version" = "2008-10-17"
  })
}

resource "aws_sns_topic_subscription" "dynamodb_sns_subscription" {
  for_each  = toset(var.dynamodb_sns_subscriptionendpoints)
  protocol  = var.dynamodb_sns_subscriptionprotocol
  endpoint  = each.value
  topic_arn = aws_sns_topic.dynamodb_sns_topic.arn
}
#================ End of SNS Configurations ============