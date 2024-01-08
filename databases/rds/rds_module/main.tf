#================ RDS Configurations ===================
resource "aws_db_instance" "rds_db_instance" {
  identifier                            = local.rds_instance_name
  engine                                = var.rds_instance_engine
  engine_version                        = local.rds_instance_engine[var.rds_instance_engine]["engineversion"][var.rds_instance_engineversion]
  license_model                         = local.rds_instance_engine[var.rds_instance_engine]["licensemodel"]
  multi_az                              = local.environment == "PROD" ? true : false
  allow_major_version_upgrade           = false
  auto_minor_version_upgrade            = false
  parameter_group_name                  = aws_db_parameter_group.rds_parametergroup_instance.name
  option_group_name                     = aws_db_option_group.rds_optiongroup_instance.name
  db_subnet_group_name                  = aws_db_subnet_group.rds_subnetgroup_instance.name
  vpc_security_group_ids                = [aws_security_group.rds_securitygroup_instance.id]
  instance_class                        = var.rds_instance_instanceclass
  kms_key_id                            = aws_kms_key.rds_kms_key.arn
  storage_encrypted                     = true
  allocated_storage                     = var.rds_storage_allocated
  max_allocated_storage                 = var.rds_storage_maxallocated
  storage_type                          = var.rds_storage_type
  iops                                  = var.rds_storage_type == "io1" || var.rds_storage_type == "gp3" ? var.rds_storage_iops : 0
  character_set_name                    = local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "oracle" || local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "mssql" ? var.rds_instance_characterset : null
  nchar_character_set_name              = local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "oracle" ? var.rds_instance_ncharcharacterset : null
  timezone                              = local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "mssql" ? var.rds_instance_timezone : null
  domain                                = null
  domain_iam_role_name                  = null
  ca_cert_identifier                    = null
  iam_database_authentication_enabled   = false
  username                              = jsondecode(data.aws_secretsmanager_secret_version.rds_admin_creds.secret_string)["username"]
  password                              = jsondecode(data.aws_secretsmanager_secret_version.rds_admin_creds.secret_string)["password"]
  db_name                               = var.rds_database_name
  port                                  = local.rds_instance_engine[var.rds_instance_engine]["port"]
  network_type                          = "IPV4"
  enabled_cloudwatch_logs_exports       = local.rds_instance_engine[var.rds_instance_engine]["cwlogs"]
  monitoring_interval                   = 10
  monitoring_role_arn                   = aws_iam_role.rds_iamrole_enhancedmonitoring.arn
  performance_insights_enabled          = substr(var.rds_instance_instanceclass, 0, 4) == "db.t" ? local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "mysql" ? false : true : true
  performance_insights_kms_key_id       = substr(var.rds_instance_instanceclass, 0, 4) == "db.t" ? local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "mysql" ? null : aws_kms_key.rds_kms_key.arn : aws_kms_key.rds_kms_key.arn
  performance_insights_retention_period = substr(var.rds_instance_instanceclass, 0, 4) == "db.t" ? local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "mysql" ? null : 7 : 7
  publicly_accessible                   = false
  maintenance_window                    = "sun:04:00-sun:04:30"
  backup_window                         = "03:00-03:30"
  backup_retention_period               = local.environment == "PROD" ? 30 : 7
  delete_automated_backups              = local.environment == "PROD" ? false : true
  backup_target                         = "region"
  replica_mode                          = local.rds_instance_engine[var.rds_instance_engine]["commonname"] == "oracle" ? var.rds_instance_replicamode : null
  copy_tags_to_snapshot                 = true
  skip_final_snapshot                   = true
  deletion_protection                   = true
  apply_immediately                     = true
  tags                                  = merge(local.tags, { Name : local.rds_instance_name })
}

resource "aws_db_event_subscription" "rds_db_instanceeventsubscription" {
  name             = "${local.rds_instance_name}-instanceeventsubscription"
  source_ids       = [aws_db_instance.rds_db_instance.identifier]
  source_type      = "db-instance"
  event_categories = ["configuration change", "deletion", "failover", "failure", "notification", "availability", "recovery", "low storage", "security"]
  enabled          = true
  sns_topic        = aws_sns_topic.rds_sns_topic.arn
  tags             = merge(local.tags, { Name : local.rds_instance_name })
}
#================ End of RDS Configurations ============