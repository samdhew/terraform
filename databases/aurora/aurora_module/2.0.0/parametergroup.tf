#================ ParameterGroup Configurations ===================
resource "aws_rds_cluster_parameter_group" "aurora_parametergroup_cluster" {
  name        = local.aurora_parametergroupcluster_name
  description = local.aurora_parametergroupcluster_name
  # family      = var.aurora_paramtergroup_family[var.aurora_cluster_engineversion]
  family = local.aurora_cluster_engine[var.aurora_cluster_engine]["parameterfamily"][var.aurora_cluster_engineversion]
  dynamic "parameter" {
    for_each = local.aurora_parametergroupcluster_data.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.aurora_parametergroupcluster_name })
}

resource "aws_db_parameter_group" "aurora_parametergroup_instance" {
  name        = local.aurora_parametergroupinstance_name
  description = local.aurora_parametergroupinstance_name
  # family      = var.aurora_paramtergroup_family[var.aurora_cluster_engineversion]
  family = local.aurora_cluster_engine[var.aurora_cluster_engine]["parameterfamily"][var.aurora_cluster_engineversion]
  dynamic "parameter" {
    for_each = local.aurora_parametergroupinstance_data.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.aurora_parametergroupinstance_name })
}

# resource "aws_db_event_subscription" "aurora_parametergroup_clustereventsubscription" {
#   name             = "${local.aurora_parametergroupcluster_name}-parametergroupeventsubscription"
#   source_ids       = [aws_rds_cluster_parameter_group.aurora_parametergroup_cluster.name]
#   source_type      = "db-parameter-group"
#   event_categories = ["configuration change"]
#   enabled          = true
#   sns_topic        = aws_sns_topic.aurora_sns_topic.arn
#   tags             = merge(local.tags, { Name : local.aurora_parametergroupcluster_name })
# }

# resource "aws_db_event_subscription" "aurora_parametergroup_instanceeventsubscription" {
#   name             = "${local.aurora_parametergroupinstance_name}-parametergroupeventsubscription"
#   source_ids       = [aws_db_parameter_group.aurora_parametergroup_instance.name]
#   source_type      = "db-parameter-group"
#   event_categories = ["configuration change"]
#   enabled          = true
#   sns_topic        = aws_sns_topic.aurora_sns_topic.arn
#   tags             = merge(local.tags, { Name : local.aurora_parametergroupinstance_name })
# }
#================ End of ParameterGroup Configurations ============