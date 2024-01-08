locals {
  account_id                     = data.aws_caller_identity.current.account_id
  region                         = data.aws_region.current.name
  app_name                       = lookup(var.mandatory_tags, "t_AppName", "")
  environment                    = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                    = var.keyspaces_keyspace_name == null ? lower("${local.app_name}-${local.environment}") : lower("${var.keyspaces_keyspace_name}-${local.environment}")
  keyspacesec2_iamrole_name      = lower("${local.unique_name}-keyspacesec2-iamrole")
  keyspacesec2_iampolicy_name    = lower("${local.unique_name}-keyspacesec2-iampolicy")
  custom_iampolicy_name          = lower("${local.unique_name}-custom-iampolicy")
  keyspaces_kms_name             = lower("${local.unique_name}-kms")
  keyspaces_sns_name             = lower("${local.unique_name}-sns")
  keyspaces_keyspace_name        = var.keyspaces_keyspace_name == null ? lower("${local.app_name}_${local.environment}") : lower("${var.keyspaces_keyspace_name}_${local.environment}")
  keyspaces_route53_cname        = local.unique_name
  keyspaces_tabledefinition_file = var.keyspaces_tabledefinition_file == null ? "keyspaces_table_definition.json" : var.keyspaces_tabledefinition_file
  keyspaces_tabledefinition_data = jsondecode(file("TFCustomResourceConfigs/${local.keyspaces_tabledefinition_file}"))
  tags                           = merge(var.mandatory_tags, var.default_tags)
}