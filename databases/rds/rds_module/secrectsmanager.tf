#================ SecretsManager Configurations ===================
resource "random_password" "rds_secretsmanager_password" {
  length           = 16
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "aws_secretsmanager_secret" "rds_secretsmanager_secret" {
  name        = local.rds_secret_name
  description = local.rds_secret_name
  kms_key_id  = aws_kms_key.rds_kms_key.arn
  tags        = merge(local.tags, { Name : local.rds_secret_name })
}

resource "aws_secretsmanager_secret_version" "rds_secretsmanager_oldversion" {
  secret_id     = aws_secretsmanager_secret.rds_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "username" : "${local.rds_instance_engine[var.rds_instance_engine]["username"]}",
    "password" : "${random_password.rds_secretsmanager_password.result}"
  }
  EOF
}

resource "aws_secretsmanager_secret_version" "rds_secretsmanager_newversion" {
  secret_id     = aws_secretsmanager_secret.rds_secretsmanager_secret.arn
  secret_string = <<EOF
  {
    "instance_identifier" : "${aws_db_instance.rds_db_instance.identifier}",
    "engine" : "${aws_db_instance.rds_db_instance.engine}",
    "username" : "${jsondecode(data.aws_secretsmanager_secret_version.rds_admin_creds.secret_string)["username"]}",
    "password" : "${jsondecode(data.aws_secretsmanager_secret_version.rds_admin_creds.secret_string)["password"]}",
    "database_name" : "${aws_db_instance.rds_db_instance.db_name}",
    "host" : "${aws_db_instance.rds_db_instance.address}",
    "port" : "${aws_db_instance.rds_db_instance.port}",
    "cname" : "${aws_route53_record.rds_route53_cname.name}"
  }
  EOF
  depends_on    = [aws_route53_record.rds_route53_cname]
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.rds_secretsmanager_secret.arn
# }
#================ End of SecretsManager Configurations ============