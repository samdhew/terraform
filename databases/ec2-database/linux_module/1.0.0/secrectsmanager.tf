#================ SecretsManager Configurations ===================
resource "random_password" "ec2database_secretsmanager_password" {
  length           = 16
  min_upper        = 5
  special          = true
  override_special = "_%#!"
}

resource "tls_private_key" "ec2database_privatekey_rsa4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_secretsmanager_secret" "ec2database_secretsmanager_secretsshkey" {
  name        = local.ec2database_secretsshkey_name
  description = local.ec2database_secretsshkey_name
  kms_key_id  = aws_kms_key.ec2database_kms_key.arn
  tags        = merge(local.tags, { Name : local.ec2database_secretsshkey_name })
}

resource "aws_secretsmanager_secret_version" "ec2database_secretsmanager_oldversionsshkey" {
  secret_id     = aws_secretsmanager_secret.ec2database_secretsmanager_secretsshkey.arn
  secret_string = tls_private_key.ec2database_privatekey_rsa4096.public_key_openssh
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.ec2database_secretsmanager_secret.arn
# }

resource "aws_secretsmanager_secret" "ec2database_secretsmanager_secretadmin" {
  name        = local.ec2database_secretadmin_name
  description = local.ec2database_secretadmin_name
  kms_key_id  = aws_kms_key.ec2database_kms_key.arn
  tags        = merge(local.tags, { Name : local.ec2database_secretadmin_name })
}

resource "aws_secretsmanager_secret_version" "ec2database_secretsmanager_oldversionadmin" {
  secret_id     = aws_secretsmanager_secret.ec2database_secretsmanager_secretadmin.arn
  secret_string = <<EOF
  {
    "username" : "${local.ec2database_cluster_engine[var.ec2database_cluster_engine]["username"]}",
    "password" : "${random_password.ec2database_secretsmanager_password.result}"
  }
  EOF
}

# resource "aws_secretsmanager_secret_rotation" "secretrotation_cert_documentdb_3pl" {
#   rotation_lambda_arn = ""
#   secret_id           = aws_secretsmanager_secret.ec2database_secretsmanager_secretadmin.arn
# }
#================ End of SecretsManager Configurations ============