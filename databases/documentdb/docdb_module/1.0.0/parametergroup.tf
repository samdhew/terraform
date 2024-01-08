#================ ParameterGroup Configurations ===================
resource "aws_docdb_cluster_parameter_group" "docdb_parametergroup_cluster" {
  name        = local.docdb_parametergroupcluster_name
  description = local.docdb_parametergroupcluster_name
  family      = local.docdb_cluster_engine[var.docdb_cluster_engine]["parameterfamily"][var.docdb_cluster_engineversion]
  dynamic "parameter" {
    for_each = local.docdb_parametergroupcluster_data.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.docdb_parametergroupcluster_name })
}

# resource "aws_docdb_event_subscription" "docdb_parametergroup_clustereventsubscription" {
#   name             = "${local.docdb_parametergroupcluster_name}-parametergroupeventsubscription"
#   source_ids       = [aws_docdb_cluster_parameter_group.docdb_parametergroup_cluster.name]
#   source_type      = "db-parameter-group"
#   event_categories = ["configuration change"]
#   enabled          = true
#   sns_topic_arn    = aws_sns_topic.docdb_sns_topic.arn
#   tags             = merge(local.tags, { Name : local.docdb_parametergroupcluster_name })
# }
#================ End of ParameterGroup Configurations ============