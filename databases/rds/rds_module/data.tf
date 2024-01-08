data "aws_caller_identity" "current" {}
# data "aws_region" "current" {}
data "template_file" "iam_custompolicy" {
  template = var.iam_customepolicy_file == null ? file("${path.module}/TFCustomResourceConfigs/iam_custompolicy.json") : file("TFCustomResourceConfigs/${var.iam_customepolicy_file}")
}
data "aws_iam_policy_document" "lambda_assumerole_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "rdsmonitoring_assumerole_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
data "aws_secretsmanager_secret_version" "rds_admin_creds" {
  secret_id  = aws_secretsmanager_secret.rds_secretsmanager_secret.arn
  depends_on = [aws_secretsmanager_secret_version.rds_secretsmanager_oldversion]
}
data "aws_subnets" "rds_subnetgroup_db" {
  filter {
    name   = "vpc-id"
    values = [var.rds_securitygroup_vpcid]
  }
  tags = {
    Name = "*db*"
  }
}
data "aws_subnet" "rds_subnetgroup_db" {
  for_each = toset(data.aws_subnets.rds_subnetgroup_db.ids)
  id       = each.value
}
data "aws_route53_zone" "rds_route53_hostedzoneid" {
  zone_id      = var.rds_route53_hostedzoneid
  private_zone = false
}