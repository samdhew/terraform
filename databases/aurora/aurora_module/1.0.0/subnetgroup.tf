#================ SubnetGroup Configurations ===================
resource "aws_db_subnet_group" "aurora_subnetgroup_cluster" {
  name        = local.aurora_subnetgroup_name
  description = local.aurora_subnetgroup_name
  subnet_ids  = var.aurora_subnetgroup_subnets == null ? [for a in data.aws_subnet.aurora_subnetgroup_db : a.id] : var.aurora_subnetgroup_subnets
  tags        = merge(local.tags, { Name : local.aurora_subnetgroup_name })
}
#================ End of SubnetGroup Configurations ============