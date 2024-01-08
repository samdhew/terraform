#================ SubnetGroup Configurations ===================
resource "aws_dms_replication_subnet_group" "dms_subnetgroup_instance" {
  replication_subnet_group_id          = local.dms_subnetgroup_name
  replication_subnet_group_description = local.dms_subnetgroup_name
  subnet_ids                           = var.dms_subnetgroup_subnets == null ? [for a in data.aws_subnet.dms_subnetgroup_db : a.id] : var.dms_subnetgroup_subnets
  tags                                 = merge(local.tags, { Name : local.dms_subnetgroup_name })
}
#================ End of SubnetGroup Configurations ============