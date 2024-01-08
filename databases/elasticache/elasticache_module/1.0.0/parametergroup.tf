#================ ParameterGroup Configurations ===================
resource "aws_elasticache_parameter_group" "elasticache_parametergroup_cluster" {
  name        = local.elasticache_parametergroupcluster_name
  description = local.elasticache_parametergroupcluster_name
  family      = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["parameterfamily"][var.elasticache_cluster_engineversion]
  dynamic "parameter" {
    for_each = local.elasticache_parametergroupcluster_data.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
      # apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.elasticache_parametergroupcluster_name })
}
#================ End of ParameterGroup Configurations ============