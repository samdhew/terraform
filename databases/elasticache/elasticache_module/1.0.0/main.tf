#================ ElasticacheCluster Configurations ===================
resource "aws_elasticache_cluster" "elasticache_cluster_cluster" {
  cluster_id                   = local.elasticache_cluster_name
  engine                       = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] : null
  engine_version               = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engineversion"][var.elasticache_cluster_engineversion] : null
  replication_group_id         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? null : aws_elasticache_replication_group.elasticache_replicationgroup_cluster[0].replication_group_id
  az_mode                      = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.environment == "PROD" ? "cross-az" : "cross-az" : null
  auto_minor_version_upgrade   = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? null : false
  parameter_group_name         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? aws_elasticache_parameter_group.elasticache_parametergroup_cluster.name : null
  preferred_availability_zones = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? var.elasticache_cluster_azs == null ? [for a in data.aws_subnet.elasticache_subnetgroup_db : a.availability_zone] : var.elasticache_cluster_azs : null
  subnet_group_name            = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? aws_elasticache_subnet_group.elasticache_subnetgroup_cluster.name : null
  security_group_ids           = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? [aws_security_group.elasticache_securitygroup_cluster.id] : null
  port                         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.elasticache_cluster_engine[var.elasticache_cluster_engine]["port"] : null
  ip_discovery                 = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? "ipv4" : null
  network_type                 = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? "ipv4" : null
  node_type                    = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? var.elasticache_cluster_instanceclass : null
  num_cache_nodes              = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PROD" ? 3 : 3 : null
  notification_topic_arn       = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? aws_sns_topic.elasticache_sns_topic.arn : null
  maintenance_window           = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? "sun:04:00-sun:05:00" : null
  snapshot_window              = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? null : "03:00-04:00" : null
  snapshot_retention_limit     = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? null : local.environment == "PROD" ? 30 : 7 : null
  apply_immediately            = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? true : null
  tags                         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? merge(local.tags, { Name : local.elasticache_cluster_name }) : null
}
#================ End of ElasticacheCluster Configurations ============