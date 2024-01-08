#================ DMS Task Configurations ===================
resource "aws_dms_replication_task" "dms_replication_task" {
  for_each                  = [{ for task in local.dms_replicationtask_data.tasks : task.replication_task_id => task }, {}][var.dms_replicationtask_create == true ? 0 : 1]
  replication_task_id       = each.value.replication_task_id
  replication_instance_arn  = aws_dms_replication_instance.dms_replication_instance.replication_instance_arn
  source_endpoint_arn       = each.value.source_endpoint_arn
  target_endpoint_arn       = each.value.target_endpoint_arn
  migration_type            = each.value.migration_type
  cdc_start_time            = each.value.cdc_start_position != null ? null : each.value.cdc_start_time
  cdc_start_position        = each.value.cdc_start_time == null ? null : each.value.cdc_start_position
  replication_task_settings = jsonencode(each.value.replication_task_settings)
  table_mappings            = jsonencode(each.value.table_mappings)
  depends_on                = [aws_dms_replication_instance.dms_replication_instance, aws_dms_endpoint.dms_replication_endpoint]
  tags                      = merge(local.tags, { Name : local.dms_replicationendpoint_name })
}
#================ End of DMS Task Configurations ============