locals {
  account_id = data.aws_caller_identity.current.account_id
  # region                               = data.aws_region.current.name
  app_name                                 = lookup(var.mandatory_tags, "t_AppName", "")
  environment                              = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                              = var.elasticache_cluster_name == null ? lower("${local.app_name}-${local.environment}-${local.elasticache_cluster_engine[var.elasticache_cluster_engine]["commonname"]}") : lower("${var.elasticache_cluster_name}-${local.environment}-${local.elasticache_cluster_engine[var.elasticache_cluster_engine]["commonname"]}")
  elasticache_kms_name                     = lower("${local.unique_name}-kms")
  elasticache_sns_name                     = lower("${local.unique_name}-sns")
  elasticache_secretadmin_name             = lower("${local.unique_name}-adminsecret")
  elasticache_secretapp_name               = lower("${local.unique_name}-appsecret")
  elasticache_securitygroup_name           = lower("${local.unique_name}-securitygroup")
  elasticache_subnetgroup_name             = lower("${local.unique_name}-subnetgroup")
  elasticache_parametergroupcluster_name   = lower("${local.unique_name}-parametergroupcluster")
  elasticache_loggroupprefix_name          = lower(local.unique_name)
  elasticache_useradmin_name               = lower("${local.unique_name}-admin")
  elasticache_userwriteapp_name            = lower(local.unique_name)
  elasticache_userreadapp_name             = lower("${local.unique_name}-reader")
  elasticache_usergroupadmin_name          = lower("${local.unique_name}-admin")
  elasticache_usergroupapp_name            = lower("${local.unique_name}-app")
  elasticache_replicationgroupprimary_name = lower("${local.unique_name}-replicationgroupprimary")
  elasticache_cluster_name                 = lower("${local.unique_name}-cluster")
  elasticache_route53_cname                = local.unique_name
  elasticache_cluster_engine = {
    elasticache-memcached = {
      engine = "memcached"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "1.4.34" = "1.4.34"
        "1.5.16" = "1.5.16"
        "1.6.17" = "1.6.17"
      }
      parameterfamily = {
        "1.4.34" = "memcached1.4"
        "1.5.16" = "memcached1.5"
        "1.6.17" = "memcached1.6"
      }
      username   = "memcachedAdmin"
      port       = "11211"
      cwlogs     = ["engine-log", "slow-log"]
      commonname = "memcached"
    }
    elasticache-redis = {
      engine = "redis"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "4.0.10" = "4.0.10"
        "5.0.6"  = "5.0.6"
        "6.2"    = "6.2"
        "7.0"    = "7.0"
      }
      parameterfamily = {
        "4.0.10" = "redis4.0"
        "5.0.6"  = "redis5.0"
        "6.2"    = "redis6.x"
        "7.0"    = "redis7"
      }
      username   = "redisAdmin"
      port       = "6379"
      cwlogs     = ["engine-log", "slow-log"]
      commonname = "redis"
    }
  }
  elasticache_parametergroupcluster_file = var.elasticache_parametergroupcluster_file == null ? "elasticache_parametergroup_cluster.json" : var.elasticache_parametergroupcluster_file
  elasticache_parametergroupcluster_data = jsondecode(file("TFCustomResourceConfigs/${local.elasticache_parametergroupcluster_file}"))
  tags                                   = merge(var.mandatory_tags, var.default_tags)
}