#================ SubnetGroup Configurations ===================
resource "aws_db_subnet_group" "rds_subnetgroup_instance" {
  name        = local.rds_subnetgroup_name
  description = local.rds_subnetgroup_name
  subnet_ids  = var.rds_subnetgroup_subnets == null ? [for a in data.aws_subnet.rds_subnetgroup_db : a.id] : var.rds_subnetgroup_subnets
  tags        = merge(local.tags, { Name : local.rds_subnetgroup_name })
}
#================ End of SubnetGroup Configurations ============