#================ CloudWatchAlarm Configurations ===================
resource "aws_cloudwatch_log_group" "dms_loggroup_engine" {
  name              = "/aws/dms/${local.dms_loggroupprefix_name}/${local.dms_replicationinstance_engine[var.dms_replicationinstance_engine]["commonname"]}"
  skip_destroy      = false
  retention_in_days = 365
  kms_key_id        = aws_kms_key.dms_kms_key.arn
  tags              = merge(local.tags)
}
#================ End of CloudWatchAlarm Configurations ============