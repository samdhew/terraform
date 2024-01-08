#================ ReplicationGroup Configurations ===================
resource "aws_elasticache_replication_group" "elasticache_replicationgroup_cluster" {
  count                      = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  replication_group_id       = local.elasticache_replicationgroupprimary_name
  description                = local.elasticache_replicationgroupprimary_name
  engine                     = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"]
  engine_version             = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engineversion"][var.elasticache_cluster_engineversion]
  multi_az_enabled           = local.environment == "PROD" ? true : true
  automatic_failover_enabled = true
  auto_minor_version_upgrade = false
  parameter_group_name       = aws_elasticache_parameter_group.elasticache_parametergroup_cluster.name
  preferred_cache_cluster_azs = var.elasticache_cluster_azs == null ? [for a in data.aws_subnet.elasticache_subnetgroup_db : a.availability_zone] : var.elasticache_cluster_azs
  subnet_group_name          = aws_elasticache_subnet_group.elasticache_subnetgroup_cluster.name
  security_group_ids         = [aws_security_group.elasticache_securitygroup_cluster.id]
  kms_key_id                 = aws_kms_key.elasticache_kms_key.arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  user_group_ids             = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? [aws_elasticache_user_group.elasticache_usergroup_admin[0].user_group_id] : null
  # auth_token                  = jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["auth"]
  port                 = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["port"]
  data_tiering_enabled = false
  node_type            = var.elasticache_cluster_instanceclass
  num_cache_clusters   = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PROD" ? 3 : 3
  # num_node_groups         = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PROD" ? 1 : 1
  # replicas_per_node_group = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PROD" ? 2 : 1
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.elasticache_loggroup_engine.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.elasticache_loggroup_slow.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  notification_topic_arn   = aws_sns_topic.elasticache_sns_topic.arn
  maintenance_window       = "sun:04:00-sun:05:00"
  snapshot_window          = "03:00-04:00"
  snapshot_retention_limit = local.environment == "PROD" ? 30 : 7
  apply_immediately        = true
  tags                     = merge(local.tags, { Name : local.elasticache_replicationgroupprimary_name })
}
#================ End of ReplicationGroup Configurations ============