#================ SecurityGroup Configurations ===================
resource "aws_security_group" "docdb_securitygroup_cluster" {
  name        = local.docdb_securitygroup_name
  description = local.docdb_securitygroup_name
  vpc_id      = var.docdb_securitygroup_vpcid
  ingress = [{
    description      = local.docdb_cluster_engine[var.docdb_cluster_engine]["commonname"]
    protocol         = "tcp"
    from_port        = local.docdb_cluster_engine[var.docdb_cluster_engine]["port"]
    to_port          = local.docdb_cluster_engine[var.docdb_cluster_engine]["port"]
    cidr_blocks      = ["10.0.0.0/8"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
  egress = [{
    description      = "All egress traffic"
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.docdb_securitygroup_name })
}
#================ End of SecurityGroup Configurations ============