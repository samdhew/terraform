#================ SecretsManager Configurations ===================
resource "random_password" "docdb_secretsmanager_password" {
  length           = 16
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "aws_secretsmanager_secret" "docdb_secretsmanager_secret" {
  name        = local.docdb_secret_name
  description = local.docdb_secret_name
  kms_key_id  = aws_kms_key.docdb_kms_key.arn
  tags        = merge(local.tags, { Name : local.docdb_secret_name })
}

resource "aws_secretsmanager_secret_version" "docdb_secretsmanager_oldversion" {
  secret_id     = aws_secretsmanager_secret.docdb_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "username" : "${local.docdb_cluster_engine[var.docdb_cluster_engine]["username"]}",
    "password" : "${random_password.docdb_secretsmanager_password.result}"
  }
  EOF
}

resource "aws_secretsmanager_secret_version" "docdb_secretsmanager_newversion" {
  secret_id     = aws_secretsmanager_secret.docdb_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "cluster_identifier" : "${aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier}",
    "engine" : "${aws_docdb_cluster.docdb_cluster_cluster.engine}",
    "username" : "${jsondecode(data.aws_secretsmanager_secret_version.docdb_admin_creds.secret_string)["username"]}",
    "password" : "${jsondecode(data.aws_secretsmanager_secret_version.docdb_admin_creds.secret_string)["password"]}",
    "database_name" : "",
    "host" : "${aws_docdb_cluster.docdb_cluster_cluster.endpoint}",
    "port" : "${aws_docdb_cluster.docdb_cluster_cluster.port}",
    "cname" : "${aws_route53_record.docdb_route53_cname.name}"
  }
  EOF
  depends_on    = [aws_route53_record.docdb_route53_cname]
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.docdb_secretsmanager_secret.arn
# }
#================ End of SecretsManager Configurations ============