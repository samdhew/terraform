data "aws_caller_identity" "current" {}
# data "aws_region" "current" {}
data "template_file" "ec2database_iam_custompolicy" {
  template = var.iam_customepolicy_file == null ? file("${path.module}/TFCustomResourceConfigs/iam_custompolicy.json") : file("TFCustomResourceConfigs/${var.iam_customepolicy_file}")
}
data "template_file" "ec2database_ec2_userdata" {
  template = var.ec2_userdata_file == null ? file("TFCustomResourceConfigs/infra_setup.sh") : format("%s\n%s", file("${path.module}/TFCustomResourceConfigs/infra_setup.sh"), file("TFCustomResourceConfigs/${var.ec2_userdata_file}"))
}
data "aws_iam_policy_document" "ec2database_assumerole_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_secretsmanager_secret_version" "ec2database_sshkey_creds" {
  secret_id  = aws_secretsmanager_secret.ec2database_secretsmanager_secretsshkey.arn
  depends_on = [aws_secretsmanager_secret_version.ec2database_secretsmanager_oldversionsshkey]
}
data "aws_ami" "ec2database_ami_pcmubuntu" {
  most_recent = true
  owners      = ["056952386373"]

  filter {
    name   = "name"
    values = ["pcm-ubuntu20.04-prod-2023.08.15"]
  }
}
data "aws_subnets" "ec2database_subnetgroup_db" {
  filter {
    name   = "vpc-id"
    values = [var.ec2database_securitygroup_vpcid]
  }
  tags = {
    Name = "*db*"
  }
}
data "aws_subnet" "ec2database_subnetgroup_db" {
  for_each = toset(data.aws_subnets.ec2database_subnetgroup_db.ids)
  id       = each.value
}
# data "aws_route53_zone" "ec2database_route53_hostedzoneid" {
#   zone_id      = var.ec2database_route53_hostedzoneid
#   private_zone = false
# }