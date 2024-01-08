#================ SubnetGroup Configurations ===================
resource "aws_docdb_subnet_group" "docdb_subnetgroup_cluster" {
  name        = local.docdb_subnetgroup_name
  description = local.docdb_subnetgroup_name
  subnet_ids  = var.docdb_subnetgroup_subnets == null ? [for a in data.aws_subnet.docdb_subnetgroup_db : a.id] : var.docdb_subnetgroup_subnets
  tags        = merge(local.tags, { Name : local.docdb_subnetgroup_name })
}
#================ End of SubnetGroup Configurations ============