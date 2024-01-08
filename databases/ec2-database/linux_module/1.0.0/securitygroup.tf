#================ SecurityGroup Configurations ===================
resource "aws_security_group" "ec2database_securitygroup_database" {
  name        = local.ec2database_securitygroupdatabase_name
  description = local.ec2database_securitygroupdatabase_name
  vpc_id      = var.ec2database_securitygroup_vpcid
  dynamic "ingress" {
    for_each = local.ec2database_cluster_engine[var.ec2database_cluster_engine]["port"]
    content {
      description      = local.ec2database_cluster_engine[var.ec2database_cluster_engine]["commonname"]
      protocol         = "tcp"
      from_port        = ingress.value
      to_port          = ingress.value
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
  tags = merge(local.tags, { Name : local.ec2database_securitygroupdatabase_name })
}

resource "aws_security_group" "ec2database_securitygroup_ec2" {
  name        = local.ec2database_securitygroupec2_name
  description = local.ec2database_securitygroupec2_name
  vpc_id      = var.ec2database_securitygroup_vpcid
  ingress = [{
    description      = "ssh"
    protocol         = "tcp"
    from_port        = "22"
    to_port          = "22"
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
  tags = merge(local.tags, { Name : local.ec2database_securitygroupec2_name })
}
#================ End of SecurityGroup Configurations ============