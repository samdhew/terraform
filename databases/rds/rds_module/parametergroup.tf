#================ ParameterGroup Configurations ===================
resource "aws_db_parameter_group" "rds_parametergroup_instance" {
  name        = local.rds_parametergroupinstance_name
  description = local.rds_parametergroupinstance_name
  # family      = var.rds_paramtergroup_family[var.rds_instance_engineversion]
  family = local.rds_instance_engine[var.rds_instance_engine]["parameterfamily"][var.rds_instance_engineversion]
  dynamic "parameter" {
    for_each = local.rds_parametergroupinstance_data.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.rds_parametergroupinstance_name })
}

# resource "aws_db_event_subscription" "rds_parametergroup_instanceeventsubscription" {
#   name             = "${local.rds_parametergroupinstance_name}-parametergroupeventsubscription"
#   source_ids       = [aws_db_parameter_group.rds_parametergroup_instance.name]
#   source_type      = "db-parameter-group"
#   event_categories = ["configuration change"]
#   enabled          = true
#   sns_topic        = aws_sns_topic.rds_sns_topic.arn
#   tags             = merge(local.tags, { Name : local.rds_parametergroupinstance_name })
# }
#================ End of ParameterGroup Configurations ============