#================ SecurityGroup Configurations ===================
resource "aws_security_group" "dms_securitygroup_instance" {
  name        = local.dms_securitygroup_name
  description = local.dms_securitygroup_name
  vpc_id      = var.dms_securitygroup_vpcid
  dynamic "ingress" {
    for_each = local.dms_replicationendpoint_data.endpoints
    content {
      description      = ingress.value.engine_name
      protocol         = "tcp"
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      cidr_blocks      = ["10.0.0.0/8"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }
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
  tags = merge(local.tags, { Name : local.dms_securitygroup_name })
}
#================ End of SecurityGroup Configurations ============