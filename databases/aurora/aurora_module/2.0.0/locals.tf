locals {
  account_id = data.aws_caller_identity.current.account_id
  # region                               = data.aws_region.current.name
  app_name                           = lookup(var.mandatory_tags, "t_AppName", "")
  environment                        = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                        = var.aurora_cluster_name == null ? lower("${local.app_name}-${local.environment}-${local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"]}") : lower("${var.aurora_cluster_name}-${local.environment}-${local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"]}")
  rdslambda_iamrole_name             = lower("${local.unique_name}-rdslambda-iamrole")
  rdsenhancedmonitoring_iamrole_name = lower("${local.unique_name}-rdsenhancedmonitoring-iamrole")
  rdslambda_iampolicy_name           = lower("${local.unique_name}-rdslambda-iampolicy")
  # rdsenhancedmonitoring_iampolicy_name = lower("${local.unique_name}-rdsenhancedmonitoring-iampolicy")
  custom_iampolicy_name = lower("${local.unique_name}-custom-iampolicy")
  # rds_s3bucket_name                    = lower("${local.unique_name}-rds-s3bucket")
  aurora_kms_name                    = lower("${local.unique_name}-kms")
  aurora_sns_name                    = lower("${local.unique_name}-sns")
  aurora_secret_name                 = lower("${local.unique_name}-secret")
  aurora_securitygroup_name          = lower("${local.unique_name}-securitygroup")
  aurora_subnetgroup_name            = lower("${local.unique_name}-subnetgroup")
  aurora_parametergroupcluster_name  = lower("${local.unique_name}-parametergroupcluster")
  aurora_parametergroupinstance_name = lower("${local.unique_name}-parametergroupinstance")
  aurora_cluster_name                = lower("${local.unique_name}-cluster")
  aurora_instance_name               = lower("${local.unique_name}-instance")
  aurora_route53_cname               = local.unique_name
  aurora_cluster_engine = {
    aurora-mysql = {
      engine = "aurora-mysql"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "2.11.3" = "5.7.mysql_aurora.2.11.3"
        "2.12.0" = "5.7.mysql_aurora.2.12.0"
        "3.01.1" = "8.0.mysql_aurora.3.01.1"
        "3.02.3" = "8.0.mysql_aurora.3.02.3"
        "3.03.1" = "8.0.mysql_aurora.3.03.1"
        "3.04.0" = "8.0.mysql_aurora.3.04.0"
      }
      parameterfamily = {
        "2.11.3" = "aurora-mysql5.7"
        "2.12.0" = "aurora-mysql5.7"
        "3.01.1" = "aurora-mysql8.0"
        "3.02.3" = "aurora-mysql8.0"
        "3.03.1" = "aurora-mysql8.0"
        "3.04.0" = "aurora-mysql8.0"
      }
      username   = "mysqlAdmin"
      port       = "3306"
      cwlogs     = ["general", "audit", "error", "slowquery"]
      commonname = "mysql"
    }
    aurora-postgresql = {
      engine = "aurora-postgresql"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "13.11" = "13.11"
        "14.8"  = "14.8"
        "15.3"  = "15.3"
      }
      parameterfamily = {
        "13.11" = "aurora-postgresql13"
        "14.8"  = "aurora-postgresql14"
        "15.3"  = "aurora-postgresql15"
      }
      username   = "pgsqlAdmin"
      port       = "5432"
      cwlogs     = ["postgresql"]
      commonname = "pgsql"
    }
  }
  aurora_parametergroupcluster_file  = var.aurora_parametergroupcluster_file == null ? local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"] == "mysql" ? "auroramysql_parametergroup_cluster.json" : "aurorapgsql_parametergroup_cluster.json" : var.aurora_parametergroupcluster_file
  aurora_parametergroupcluster_data  = jsondecode(file("TFCustomResourceConfigs/${local.aurora_parametergroupcluster_file}"))
  aurora_parametergroupinstance_file = var.aurora_parametergroupinstance_file == null ? local.aurora_cluster_engine[var.aurora_cluster_engine]["commonname"] == "mysql" ? "auroramysql_parametergroup_instance.json" : "aurorapgsql_parametergroup_instance.json" : var.aurora_parametergroupinstance_file
  aurora_parametergroupinstance_data = jsondecode(file("TFCustomResourceConfigs/${local.aurora_parametergroupinstance_file}"))
  tags                               = merge(var.mandatory_tags, var.default_tags)
  # temp_tags = concat(
  #   [
  #     for key, value in local.tags :
  #     {
  #       key                 = key
  #       value               = value
  #       propagate_at_launch = true
  #     }
  #   ]
  # )
}