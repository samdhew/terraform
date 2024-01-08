#================ SecurityGroup Configurations ===================
resource "aws_security_group" "rds_securitygroup_instance" {
  name        = local.rds_securitygroup_name
  description = local.rds_securitygroup_name
  vpc_id      = var.rds_securitygroup_vpcid
  ingress = [{
    description      = local.rds_instance_engine[var.rds_instance_engine]["commonname"]
    protocol         = "tcp"
    from_port        = local.rds_instance_engine[var.rds_instance_engine]["port"]
    to_port          = local.rds_instance_engine[var.rds_instance_engine]["port"]
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
  tags = merge(local.tags, { Name : local.rds_securitygroup_name })
}
#================ End of SecurityGroup Configurations ============