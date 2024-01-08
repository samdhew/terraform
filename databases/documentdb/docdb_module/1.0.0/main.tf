#================ DocumentDBCluster Configurations ===================
resource "aws_docdb_cluster" "docdb_cluster_cluster" {
  cluster_identifier              = local.docdb_cluster_name
  engine                          = var.docdb_cluster_engine
  engine_version                  = local.docdb_cluster_engine[var.docdb_cluster_engine]["engineversion"][var.docdb_cluster_engineversion]
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb_parametergroup_cluster.name
  availability_zones              = var.docdb_cluster_azs == null ? [for a in data.aws_subnet.docdb_subnetgroup_db : a.availability_zone] : var.docdb_cluster_azs
  db_subnet_group_name            = aws_docdb_subnet_group.docdb_subnetgroup_cluster.name
  vpc_security_group_ids          = [aws_security_group.docdb_securitygroup_cluster.id]
  kms_key_id                      = aws_kms_key.docdb_kms_key.arn
  storage_encrypted               = true
  master_username                 = jsondecode(data.aws_secretsmanager_secret_version.docdb_admin_creds.secret_string)["username"]
  master_password                 = jsondecode(data.aws_secretsmanager_secret_version.docdb_admin_creds.secret_string)["password"]
  port                            = local.docdb_cluster_engine[var.docdb_cluster_engine]["port"]
  enabled_cloudwatch_logs_exports = local.docdb_cluster_engine[var.docdb_cluster_engine]["cwlogs"]
  preferred_maintenance_window    = "sun:04:00-sun:04:30"
  preferred_backup_window         = "03:00-03:30"
  backup_retention_period         = local.environment == "PROD" ? 30 : 7
  skip_final_snapshot             = true
  deletion_protection             = true
  apply_immediately               = true
  tags                            = merge(local.tags, { Name : local.docdb_cluster_name })
}

resource "aws_docdb_event_subscription" "docdb_cluster_clustereventsubscription" {
  name             = "${local.docdb_cluster_name}-clustereventsubscription"
  source_ids       = [aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier]
  source_type      = "db-cluster"
  event_categories = ["configuration change", "deletion", "failover", "failure", "notification"]
  enabled          = true
  sns_topic_arn    = aws_sns_topic.docdb_sns_topic.arn
  tags             = merge(local.tags, { Name : local.docdb_cluster_name })
}
#================ End of DocumentDBCluster Configurations ============

#================ DocumentDBInstance Configurations ===================
resource "aws_docdb_cluster_instance" "docdb_cluster_instance" {
  cluster_identifier              = aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier
  identifier                      = "${local.docdb_instance_name}-${count.index + 1}"
  engine                          = aws_docdb_cluster.docdb_cluster_cluster.engine
  auto_minor_version_upgrade      = false
  instance_class                  = var.docdb_cluster_instanceclass
  count                           = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PRD" || local.environment == "PROD" ? 3 : 2
  promotion_tier                  = 1
  enable_performance_insights     = true
  performance_insights_kms_key_id = aws_kms_key.docdb_kms_key.arn
  preferred_maintenance_window    = "sun:04:00-sun:04:30"
  apply_immediately               = true
  depends_on                      = [aws_docdb_cluster.docdb_cluster_cluster]
  # tags                            = merge(local.tags, { Name : "${aws_docdb_cluster_instance.docdb_cluster_instance.identifier}" })
  tags = merge(local.tags, { cluster_identifier : aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier })
}

resource "aws_docdb_event_subscription" "docdb_cluster_instanceeventsubscription" {
  name             = "${local.docdb_instance_name}-instanceeventsubscription"
  source_ids       = aws_docdb_cluster_instance.docdb_cluster_instance[*].identifier
  source_type      = "db-instance"
  event_categories = ["configuration change", "deletion", "failover", "failure", "notification", "availability", "recovery"]
  enabled          = true
  sns_topic_arn    = aws_sns_topic.docdb_sns_topic.arn
  tags             = merge(local.tags, { cluster_identifier : aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier })
}
#================ End of DocumentDBInstance Configurations ============