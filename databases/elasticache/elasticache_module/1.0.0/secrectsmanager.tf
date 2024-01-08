#================ SecretsManager Configurations ===================
resource "random_password" "elasticache_secretsmanager_authpassword" {
  length           = 32
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "random_password" "elasticache_secretsmanager_adminpassword" {
  length           = 20
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "random_password" "elasticache_secretsmanager_writerpassword" {
  length           = 20
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "random_password" "elasticache_secretsmanager_readerpassword" {
  length           = 20
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}
resource "aws_secretsmanager_secret" "elasticache_secretsmanager_adminsecret" {
  name        = local.elasticache_secretadmin_name
  description = local.elasticache_secretadmin_name
  kms_key_id  = aws_kms_key.elasticache_kms_key.arn
  tags        = merge(local.tags, { Name : local.elasticache_secretadmin_name })
}

resource "aws_secretsmanager_secret_version" "elasticache_secretsmanager_adminoldversion" {
  secret_id     = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.arn
  secret_string = <<EOF
  {
    "username" : "${local.elasticache_useradmin_name}",
    "password" : "${random_password.elasticache_secretsmanager_adminpassword.result}",
    "auth" : "${random_password.elasticache_secretsmanager_authpassword.result}"
  }
  EOF
}

resource "aws_secretsmanager_secret_version" "elasticache_secretsmanager_adminnewversion" {
  secret_id     = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.arn
  secret_string = <<EOF
  {
    "cluster_identifier" : "${aws_elasticache_cluster.elasticache_cluster_cluster.cluster_id}",
    "engine" : "${aws_elasticache_cluster.elasticache_cluster_cluster.engine}",
    "username" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["username"]}",
    "password" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["password"]}",
    "auth" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["auth"]}",
    "database_name" : "",
    "host" : "${local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? aws_elasticache_cluster.elasticache_cluster_cluster.cluster_address : trimsuffix(aws_elasticache_replication_group.elasticache_replicationgroup_cluster[0].primary_endpoint_address, ":6379")}",
    "port" : "${aws_elasticache_cluster.elasticache_cluster_cluster.port}",
    "cname" : "${aws_route53_record.elasticache_route53_cname.name}"
  }
  EOF
  depends_on    = [aws_route53_record.elasticache_route53_cname]
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.arn
# }

resource "aws_secretsmanager_secret" "elasticache_secretsmanager_appsecret" {
  name        = local.elasticache_secretapp_name
  description = local.elasticache_secretapp_name
  kms_key_id  = aws_kms_key.elasticache_kms_key.arn
  tags        = merge(local.tags, { Name : local.elasticache_secretapp_name })
}

resource "aws_secretsmanager_secret_version" "elasticache_secretsmanager_appoldversion" {
  secret_id     = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.arn
  secret_string = <<EOF
  {
    "writer_username" : "${local.elasticache_userwriteapp_name}",
    "writer_password" : "${random_password.elasticache_secretsmanager_writerpassword.result}",
    "reader_username" : "${local.elasticache_useradmin_name}",
    "reader_password" : "${random_password.elasticache_secretsmanager_readerpassword.result}"
  }
  EOF
}

resource "aws_secretsmanager_secret_version" "elasticache_secretsmanager_appnewversion" {
  secret_id     = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.arn
  secret_string = <<EOF
  {
    "cluster_identifier" : "${aws_elasticache_cluster.elasticache_cluster_cluster.cluster_id}",
    "engine" : "${aws_elasticache_cluster.elasticache_cluster_cluster.engine}",
    "writer_username" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["writer_username"]}",
    "writer_password" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["writer_password"]}",
    "reader_username" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["reader_username"]}",
    "reader_password" : "${jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["reader_password"]}",
    "database_name" : "",
    "host" : "${local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? aws_elasticache_cluster.elasticache_cluster_cluster.cluster_address : trimsuffix(aws_elasticache_replication_group.elasticache_replicationgroup_cluster[0].primary_endpoint_address, ":6379")}",
    "port" : "${aws_elasticache_cluster.elasticache_cluster_cluster.port}",
    "cname" : "${aws_route53_record.elasticache_route53_cname.name}"
  }
  EOF
  depends_on    = [aws_route53_record.elasticache_route53_cname]
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.arn
# }
#================ End of SecretsManager Configurations ============