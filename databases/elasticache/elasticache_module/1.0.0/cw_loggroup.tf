#================ CloudWatchAlarm Configurations ===================
resource "aws_cloudwatch_log_group" "elasticache_loggroup_engine" {
  name              = "/aws/elasticache/${local.elasticache_loggroupprefix_name}/engine-log"
  skip_destroy      = false
  retention_in_days = 365
  kms_key_id        = aws_kms_key.elasticache_kms_key.arn
  tags              = merge(local.tags)
}

resource "aws_cloudwatch_log_group" "elasticache_loggroup_slow" {
  name              = "/aws/elasticache/${local.elasticache_loggroupprefix_name}/slow-log"
  skip_destroy      = false
  retention_in_days = 365
  kms_key_id        = aws_kms_key.elasticache_kms_key.arn
  tags              = merge(local.tags)
}
#================ End of CloudWatchAlarm Configurations ============