locals {
  account_id = data.aws_caller_identity.current.account_id
  # region                               = data.aws_region.current.name
  app_name    = lookup(var.mandatory_tags, "t_AppName", "")
  environment = lookup(var.mandatory_tags, "t_environment", "")
  unique_name = var.docdb_cluster_name == null ? lower("${local.app_name}-${local.environment}-${local.docdb_cluster_engine[var.docdb_cluster_engine]["commonname"]}") : lower("${var.docdb_cluster_name}-${local.environment}-${local.docdb_cluster_engine[var.docdb_cluster_engine]["commonname"]}")
  # rdslambda_iamrole_name             = lower("${local.unique_name}-rdslambda-iamrole")
  # rdsenhancedmonitoring_iamrole_name = lower("${local.unique_name}-rdsenhancedmonitoring-iamrole")
  # rdslambda_iampolicy_name           = lower("${local.unique_name}-rdslambda-iampolicy")
  # rdsenhancedmonitoring_iampolicy_name = lower("${local.unique_name}-rdsenhancedmonitoring-iampolicy")
  # custom_iampolicy_name = lower("${local.unique_name}-custom-iampolicy")
  # rds_s3bucket_name                    = lower("${local.unique_name}-rds-s3bucket")
  docdb_kms_name                   = lower("${local.unique_name}-kms")
  docdb_sns_name                   = lower("${local.unique_name}-sns")
  docdb_secret_name                = lower("${local.unique_name}-secret")
  docdb_securitygroup_name         = lower("${local.unique_name}-securitygroup")
  docdb_subnetgroup_name           = lower("${local.unique_name}-subnetgroup")
  docdb_parametergroupcluster_name = lower("${local.unique_name}-parametergroupcluster")
  # docdb_parametergroupinstance_name = lower("${local.unique_name}-parametergroupinstance")
  docdb_cluster_name  = lower("${local.unique_name}-cluster")
  docdb_instance_name = lower("${local.unique_name}-instance")
  docdb_route53_cname = local.unique_name
  docdb_cluster_engine = {
    docdb = {
      engine = "docdb"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "3.6.0" = "3.6.0"
        "4.0.0" = "4.0.0"
        "5.0.0" = "5.0.0"
      }
      parameterfamily = {
        "3.6.0" = "docdb3.6"
        "4.0.0" = "docdb4.0"
        "5.0.0" = "docdb5.0"
      }
      username   = "docdbAdmin"
      port       = "27017"
      cwlogs     = ["audit", "profiler"]
      commonname = "docdb"
    }
  }
  docdb_parametergroupcluster_file = var.docdb_parametergroupcluster_file == null ? "docdb_parametergroup_cluster.json" : var.docdb_parametergroupcluster_file
  docdb_parametergroupcluster_data = jsondecode(file("TFCustomResourceConfigs/${local.docdb_parametergroupcluster_file}"))
  # docdb_parametergroupinstance_file = var.docdb_parametergroupinstance_file == null ? "docdb_parametergroup_instance.json" : var.docdb_parametergroupinstance_file
  # docdb_parametergroupinstance_data = jsondecode(file("TFCustomResourceConfigs/${local.docdb_parametergroupinstance_file}"))
  tags = merge(var.mandatory_tags, var.default_tags)
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