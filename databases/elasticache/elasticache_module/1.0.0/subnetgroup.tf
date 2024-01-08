#================ SubnetGroup Configurations ===================
resource "aws_elasticache_subnet_group" "elasticache_subnetgroup_cluster" {
  name        = local.elasticache_subnetgroup_name
  description = local.elasticache_subnetgroup_name
  subnet_ids  = var.elasticache_subnetgroup_subnets == null ? [for a in data.aws_subnet.elasticache_subnetgroup_db : a.id] : var.elasticache_subnetgroup_subnets
  tags        = merge(local.tags, { Name : local.elasticache_subnetgroup_name })
}
#================ End of SubnetGroup Configurations ============