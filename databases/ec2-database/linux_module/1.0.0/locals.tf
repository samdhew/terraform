locals {
  account_id                             = data.aws_caller_identity.current.account_id
  app_name                               = lookup(var.mandatory_tags, "t_AppName", "")
  environment                            = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                            = var.ec2database_cluster_name == null ? lower("${local.app_name}-${local.environment}-${local.ec2database_cluster_engine[var.ec2database_cluster_engine]["commonname"]}") : lower("${var.ec2database_cluster_name}-${local.environment}-${local.ec2database_cluster_engine[var.ec2database_cluster_engine]["commonname"]}")
  ec2database_iamrole_name               = lower("${local.unique_name}-ec2database-iamrole")
  ec2database_iaminstanceprofile_name    = lower("${local.unique_name}-ec2database-iaminstanceprofile")
  ec2database_iampolicy_name             = lower("${local.unique_name}-custom-iampolicy")
  ec2database_kms_name                   = lower("${local.unique_name}-kms")
  ec2database_sns_name                   = lower("${local.unique_name}-sns")
  ec2database_secretsshkey_name          = lower("${local.unique_name}-secretsshkey")
  ec2database_secretadmin_name           = lower("${local.unique_name}-secretadmin")
  ec2database_parametersshkey_name       = lower("${local.unique_name}-parametersshkey")
  ec2database_securitygroupdatabase_name = lower("${local.unique_name}-securitygroupdb")
  ec2database_securitygroupec2_name      = lower("${local.unique_name}-securitygroupec2")
  # ec2database_subnetgroup_name        = lower("${local.unique_name}-subnetgroup")
  ec2database_loggroupprefix_name = local.unique_name
  ec2database_sshkey_name         = lower("${local.unique_name}-admin")
  ec2database_ec2_name            = local.unique_name
  # ec2database_route53_cname           = local.unique_name
  ec2database_cluster_engine = {
    mysql = {
      engine = "mysql"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "mysqlAdmin"
      port       = ["3306"]
      commonname = "mysql"
    }
    postgresql = {
      engine = "postgresql"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "pgsqlAdmin"
      port       = ["5432"]
      commonname = "pgsql"
    }
    oracle = {
      engine = "oracle"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "oracleAdmin"
      port       = ["1521"]
      commonname = "oracle"
    }
    sqlserver = {
      engine = "sqlserver"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "sqlserverAdmin"
      port       = ["1433"]
      commonname = "sqlserver"
    }
    mongodb = {
      engine = "mongodb"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "mongoAdmin"
      port       = ["27017"]
      commonname = "mongodb"
    }
    cassandra = {
      engine = "cassandra"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "cassAdmin"
      port       = ["7000", "7001", "7199", "9042", "9160", "8888", "61620", "61621"]
      commonname = "cassandra"
    }
    redis = {
      engine = "redis"
      enginemode = {
        cluster    = "cluster"
        standalone = "standalone"
      }
      username   = "redisAdmin"
      port       = ["6379"]
      commonname = "redis"
    }
  }
  ec2database_subnet_ids = var.ec2database_subnetgroup_subnets == null ? [for a in data.aws_subnet.ec2database_subnetgroup_db : a.id] : var.ec2database_subnetgroup_subnets
  tags                   = merge(var.mandatory_tags, var.default_tags)
}