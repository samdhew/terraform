#================ SecretsManager Configurations ===================
resource "random_password" "aurora_secretsmanager_password" {
  length           = 16
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "aws_secretsmanager_secret" "aurora_secretsmanager_secret" {
  name        = local.aurora_secret_name
  description = local.aurora_secret_name
  kms_key_id  = aws_kms_key.aurora_kms_key.arn
  tags        = merge(local.tags, { Name : local.aurora_secret_name })
}

resource "aws_secretsmanager_secret_version" "aurora_secretsmanager_oldversion" {
  secret_id     = aws_secretsmanager_secret.aurora_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "username" : "${local.aurora_cluster_engine[var.aurora_cluster_engine]["username"]}",
    "password" : "${random_password.aurora_secretsmanager_password.result}"
  }
  EOF
}

resource "aws_secretsmanager_secret_version" "aurora_secretsmanager_newversion" {
  secret_id     = aws_secretsmanager_secret.aurora_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "cluster_identifier" : "${aws_rds_cluster.aurora_cluster_cluster.cluster_identifier}",
    "engine" : "${aws_rds_cluster.aurora_cluster_cluster.engine}",
    "username" : "${jsondecode(data.aws_secretsmanager_secret_version.aurora_admin_creds.secret_string)["username"]}",
    "password" : "${jsondecode(data.aws_secretsmanager_secret_version.aurora_admin_creds.secret_string)["password"]}",
    "database_name" : "${aws_rds_cluster.aurora_cluster_cluster.database_name}",
    "host" : "${aws_rds_cluster.aurora_cluster_cluster.endpoint}",
    "port" : "${aws_rds_cluster.aurora_cluster_cluster.port}",
    "cname" : "${aws_route53_record.aurora_route53_cname.name}"
  }
  EOF
  depends_on    = [aws_route53_record.aurora_route53_cname]
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.aurora_secretsmanager_secret.arn
# }
#================ End of SecretsManager Configurations ============