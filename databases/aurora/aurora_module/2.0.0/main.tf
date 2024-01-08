#================ AuroraPostgreSQLCluster Configurations ===================
resource "aws_rds_cluster" "aurora_cluster_cluster" {
  cluster_identifier              = local.aurora_cluster_name
  engine                          = var.aurora_cluster_engine
  engine_mode                     = local.aurora_cluster_engine[var.aurora_cluster_engine]["enginemode"]["provisioned"]
  engine_version                  = local.aurora_cluster_engine[var.aurora_cluster_engine]["engineversion"][var.aurora_cluster_engineversion]
  allow_major_version_upgrade     = false
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_parametergroup_cluster.name
  availability_zones              = var.aurora_cluster_azs == null ? [for a in data.aws_subnet.aurora_subnetgroup_db : a.availability_zone] : var.aurora_cluster_azs
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnetgroup_cluster.name
  vpc_security_group_ids          = [aws_security_group.aurora_securitygroup_cluster.id]
  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.aurora_cluster_instanceclass == "db.serverless" ? toset([1]) : toset([])
    content {
      min_capacity = 8
      max_capacity = 64
    }
  }
  kms_key_id                          = aws_kms_key.aurora_kms_key.arn
  storage_encrypted                   = true
  storage_type                        = null
  iam_database_authentication_enabled = false
  iam_roles                           = []
  master_username                     = jsondecode(data.aws_secretsmanager_secret_version.aurora_admin_creds.secret_string)["username"]
  master_password                     = jsondecode(data.aws_secretsmanager_secret_version.aurora_admin_creds.secret_string)["password"]
  database_name                       = var.aurora_database_name
  port                                = local.aurora_cluster_engine[var.aurora_cluster_engine]["port"]
  network_type                        = "IPV4"
  enable_http_endpoint                = false
  enabled_cloudwatch_logs_exports     = local.aurora_cluster_engine[var.aurora_cluster_engine]["cwlogs"]
  preferred_maintenance_window        = "sun:04:00-sun:04:30"
  preferred_backup_window             = "03:00-03:30"
  backup_retention_period             = local.environment == "PROD" ? 30 : 7
  copy_tags_to_snapshot               = true
  skip_final_snapshot                 = true
  deletion_protection                 = true
  apply_immediately                   = true
  tags                                = merge(local.tags, { Name : local.aurora_cluster_name })
}

resource "aws_db_event_subscription" "aurora_cluster_clustereventsubscription" {
  name             = "${local.aurora_cluster_name}-clustereventsubscription"
  source_ids       = [aws_rds_cluster.aurora_cluster_cluster.cluster_identifier]
  source_type      = "db-cluster"
  event_categories = ["configuration change", "deletion", "failover", "failure", "notification"]
  enabled          = true
  sns_topic        = aws_sns_topic.aurora_sns_topic.arn
  tags             = merge(local.tags, { Name : local.aurora_cluster_name })
}
#================ End of AuroraPostgreSQLCluster Configurations ============

#================ AuroraPostgreSQLInstance Configurations ===================
resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  cluster_identifier                    = aws_rds_cluster.aurora_cluster_cluster.cluster_identifier
  identifier                            = "${local.aurora_instance_name}-${count.index + 1}"
  engine                                = aws_rds_cluster.aurora_cluster_cluster.engine
  auto_minor_version_upgrade            = false
  db_parameter_group_name               = aws_db_parameter_group.aurora_parametergroup_instance.name
  instance_class                        = var.aurora_cluster_instanceclass
  count                                 = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PRD" || local.environment == "PROD" ? 3 : 2
  promotion_tier                        = 1
  monitoring_interval                   = 10
  monitoring_role_arn                   = aws_iam_role.rds_iamrole_enhancedmonitoring.arn
  performance_insights_enabled          = substr(var.aurora_cluster_instanceclass, 0, 4) == "db.t" ? local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"] == "mysql" ? false : true : true
  performance_insights_kms_key_id       = substr(var.aurora_cluster_instanceclass, 0, 4) == "db.t" ? local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"] == "mysql" ? null : aws_kms_key.aurora_kms_key.arn : aws_kms_key.aurora_kms_key.arn
  performance_insights_retention_period = substr(var.aurora_cluster_instanceclass, 0, 4) == "db.t" ? local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"] == "mysql" ? null : 7 : 7
  preferred_maintenance_window          = "sun:04:00-sun:04:30"
  publicly_accessible                   = false
  copy_tags_to_snapshot                 = true
  apply_immediately                     = true
  depends_on                            = [aws_rds_cluster.aurora_cluster_cluster]
  # tags                            = merge(local.tags, { Name : "${aws_aurora_cluster_instance.aurora_aurora_instance.identifier}" })
  tags = merge(local.tags, { cluster_identifier : aws_rds_cluster.aurora_cluster_cluster.cluster_identifier })
}

resource "aws_db_event_subscription" "aurora_cluster_instanceeventsubscription" {
  name             = "${local.aurora_instance_name}-instanceeventsubscription"
  source_ids       = aws_rds_cluster_instance.aurora_cluster_instance[*].identifier
  source_type      = "db-instance"
  event_categories = ["configuration change", "deletion", "failover", "failure", "notification", "availability", "recovery", "low storage", "security"]
  enabled          = true
  sns_topic        = aws_sns_topic.aurora_sns_topic.arn
  tags             = merge(local.tags, { cluster_identifier : aws_rds_cluster.aurora_cluster_cluster.cluster_identifier })
}
#================ End of AuroraPostgreSQLInstance Configurations ============