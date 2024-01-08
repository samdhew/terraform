#================ CloudWatchAlarm Configurations ===================
resource "aws_cloudwatch_log_group" "ec2database_loggroup_engine" {
  name              = "/aws/ec2database/${local.ec2database_loggroupprefix_name}/${local.ec2database_cluster_engine[var.ec2database_cluster_engine]["commonname"]}"
  skip_destroy      = false
  retention_in_days = 365
  kms_key_id        = aws_kms_key.ec2database_kms_key.arn
  tags              = merge(local.tags)
}
#================ End of CloudWatchAlarm Configurations ============