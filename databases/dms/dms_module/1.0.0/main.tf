#================ DMS Configurations ===================
resource "aws_dms_replication_instance" "dms_replication_instance" {
  replication_instance_id      = local.dms_replicationinstance_name
  engine_version               = local.dms_replicationinstance_engine[var.dms_replicationinstance_engine]["engineversion"][var.dms_replicationinstance_engineversion]
  multi_az                     = local.environment == "PROD" ? true : false
  allow_major_version_upgrade  = false
  auto_minor_version_upgrade   = false
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dms_subnetgroup_instance.replication_subnet_group_id
  vpc_security_group_ids       = [aws_security_group.dms_securitygroup_instance.id]
  replication_instance_class   = var.dms_replicationinstance_instanceclass
  kms_key_arn                  = aws_kms_key.dms_kms_key.arn
  allocated_storage            = var.dms_replicationinstance_storage
  publicly_accessible          = false
  preferred_maintenance_window = "sun:04:00-sun:04:30"
  apply_immediately            = true
  tags                         = merge(local.tags, { Name : local.dms_replicationinstance_name })
}

resource "aws_dms_event_subscription" "dms_replication_instanceeventsubscription" {
  name             = "${local.dms_replicationinstance_name}-instanceeventsubscription"
  source_ids       = [aws_dms_replication_instance.dms_replication_instance.replication_instance_id]
  source_type      = "replication-instance"
  event_categories = ["configuration change", "deletion", "failover", "failure", "low storage"]
  enabled          = true
  sns_topic_arn    = aws_sns_topic.dms_sns_topic.arn
  tags             = merge(local.tags, { Name : local.dms_replicationinstance_name })
}
#================ End of DMS Configurations ============