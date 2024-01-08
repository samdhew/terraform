locals {
  account_id                     = data.aws_caller_identity.current.account_id
  region                         = data.aws_region.current.name
  app_name                       = lookup(var.mandatory_tags, "t_AppName", "")
  environment                    = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                    = var.dynamodb_keyspace_name == null ? lower("${local.app_name}-${local.environment}") : lower("${var.dynamodb_keyspace_name}-${local.environment}")
  dynamodbec2_iamrole_name      = lower("${local.unique_name}-dynamodbec2-iamrole")
  dynamodbec2_iampolicy_name    = lower("${local.unique_name}-dynamodbec2-iampolicy")
  custom_iampolicy_name          = lower("${local.unique_name}-custom-iampolicy")
  dynamodb_kms_name             = lower("${local.unique_name}-kms")
  dynamodb_sns_name             = lower("${local.unique_name}-sns")
  dynamodb_keyspace_name        = var.dynamodb_keyspace_name == null ? lower("${local.app_name}_${local.environment}") : lower("${var.dynamodb_keyspace_name}_${local.environment}")
  dynamodb_route53_cname        = local.unique_name
  dynamodb_tabledefinition_file = var.dynamodb_tabledefinition_file == null ? "dynamodb_table_definition.json" : var.dynamodb_tabledefinition_file
  dynamodb_tabledefinition_data = jsondecode(file("TFCustomResourceConfigs/${local.dynamodb_tabledefinition_file}"))
  tags                           = merge(var.mandatory_tags, var.default_tags)
}