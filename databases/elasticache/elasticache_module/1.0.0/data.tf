data "aws_caller_identity" "current" {}
# data "aws_region" "current" {}
# data "template_file" "iam_custompolicy" {
#   template = file("TFCustomResourceConfigs/${var.iam_customepolicy_file}")
# }
# data "aws_iam_policy_document" "lambda_assumerole_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#   }
# }
# data "aws_iam_policy_document" "rdsmonitoring_assumerole_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["monitoring.rds.amazonaws.com"]
#     }
#   }
# }
data "aws_secretsmanager_secret_version" "elasticache_admin_creds" {
  secret_id  = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.arn
  depends_on = [aws_secretsmanager_secret_version.elasticache_secretsmanager_adminoldversion]
}

data "aws_secretsmanager_secret_version" "elasticache_app_creds" {
  secret_id  = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.arn
  depends_on = [aws_secretsmanager_secret_version.elasticache_secretsmanager_appoldversion]
}
data "aws_subnets" "elasticache_subnetgroup_db" {
  filter {
    name   = "vpc-id"
    values = [var.elasticache_securitygroup_vpcid]
  }
  tags = {
    Name = "*db*"
  }
}
data "aws_subnet" "elasticache_subnetgroup_db" {
  for_each = toset(data.aws_subnets.elasticache_subnetgroup_db.ids)
  id       = each.value
}
data "aws_route53_zone" "elasticache_route53_hostedzoneid" {
  zone_id      = var.elasticache_route53_hostedzoneid
  private_zone = false
}