data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
# data "template_file" "iam_custompolicy" {
#   template = var.iam_customepolicy_file == null ? file("${path.module}/TFCustomResourceConfigs/iam_custompolicy.json") : file("TFCustomResourceConfigs/${var.iam_customepolicy_file}")
# }
data "aws_iam_policy_document" "ec2_assumerole_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_route53_zone" "keyspaces_route53_hostedzoneid" {
  zone_id      = var.keyspaces_route53_hostedzoneid
  private_zone = false
}