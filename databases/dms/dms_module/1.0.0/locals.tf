locals {
  account_id = data.aws_caller_identity.current.account_id
  # region                               = data.aws_region.current.name
  app_name                       = lookup(var.mandatory_tags, "t_AppName", "")
  environment                    = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                    = var.dms_replicationinstance_name == null ? lower("${local.app_name}-${local.environment}-${local.dms_replicationinstance_engine[var.dms_replicationinstance_engine]["commonname"]}") : lower("${var.dms_replicationinstance_name}-${local.environment}-${local.dms_replicationinstance_engine[var.dms_replicationinstance_engine]["commonname"]}")
  dmsaccessendpoint_iamrole_name = lower("${local.unique_name}-accessendpoint-iamrole")
  dmscwlogs_iamrole_name         = lower("${local.unique_name}-cwlogs-iamrole")
  dmsvpc_iamrole_name            = lower("${local.unique_name}-vpc-iamrole")
  dms_kms_name                   = lower("${local.unique_name}-kms")
  dms_sns_name                   = lower("${local.unique_name}-sns")
  dms_securitygroup_name         = lower("${local.unique_name}-securitygroup")
  dms_subnetgroup_name           = lower("${local.unique_name}-subnetgroup")
  dms_loggroupprefix_name        = local.unique_name
  dms_replicationinstance_name   = lower("${local.unique_name}-instance")
  dms_replicationendpoint_name   = lower("${local.unique_name}-endpoint")
  dms_route53_cname              = local.unique_name
  dms_replicationinstance_engine = {
    dms = {
      engine = "dms"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "3.4.5" = "3.4.5"
        "3.4.6" = "3.4.6"
        "3.4.7" = "3.4.7"
        "3.5.1" = "3.5.1"
      }
      commonname = "dms"
    }
  }
  dms_replicationendpoint_file = var.dms_replicationendpoint_file == null ? "dms_replication_endpoint.json" : var.dms_replicationendpoint_file
  dms_replicationendpoint_data = jsondecode(file("TFCustomResourceConfigs/${local.dms_replicationendpoint_file}"))
  dms_replicationtask_file     = var.dms_replicationtask_file == null ? "dms_replication_task.json" : var.dms_replicationtask_file
  dms_replicationtask_data     = jsondecode(file("TFCustomResourceConfigs/${local.dms_replicationtask_file}"))
  tags                         = merge(var.mandatory_tags, var.default_tags)
}