#================ CloudWatchAlarm Configurations ===================
# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighcpu" {
#   for_each            = local.environment == "PPE" || local.environment == "PERF" || local.environment == "STG" || local.environment == "PROD" ? aws_docdb_cluster.docdb_cluster_cluster.cluster_members : []
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-CPUUtilizationHigh-Alarm"
#   alarm_name          = "${each.value}-CPUUtilizationHigh-Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 70
#   unit                      = "Percent"
#   statistic                 = "Maximum"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-CPUUtilizationHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighmemory" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-MemoryUtilizationHigh-Alarm"
#   alarm_name          = "${each.value}-MemoryUtilizationHigh-Alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "FreeableMemory"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 1000
#   unit                      = "Megabytes"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-MemoryUtilizationHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighswap" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-SwapUtilizationHigh-Alarm"
#   alarm_name          = "${each.value}-SwapUtilizationHigh-Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "SwapUsage"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 400
#   unit                      = "Megabytes"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-SwapUtilizationHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighwriteiops" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-WriteIOPSHigh-Alarm"
#   alarm_name          = "${each.value}-WriteIOPSHigh-Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "WriteIOPS"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 100
#   unit                      = "Count/Second"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-WriteIOPSHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighreadiops" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-ReadIOPSHigh-Alarm"
#   alarm_name          = "${each.value}-ReadIOPSHigh-Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "ReadIOPS"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 100
#   unit                      = "Count/Second"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-ReadIOPSHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmhighstorage" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-StorageUtilizationHigh-Alarm"
#   alarm_name          = "${each.value}-StorageUtilizationHigh-Alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "FreeLocalStorage"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 5000
#   unit                      = "Megabytes"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-StorageUtilizationHigh-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmlownetworkthroughput" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-NetworkThroughputLow-Alarm"
#   alarm_name          = "${each.value}-NetworkThroughputLow-Alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "NetworkThroughput"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 100
#   unit                      = "Bytes/Second"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-NetworkThroughputLow-Alarm" })
# }

# resource "aws_cloudwatch_metric_alarm" "docdb_cloudwatch_alarmlowdatabaseconnections" {
#   for_each            = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
#   actions_enabled     = true
#   alarm_actions       = [aws_sns_topic.docdb_sns_topic.arn]
#   alarm_description   = "${each.value}-DatabaseConnectionsLow-Alarm"
#   alarm_name          = "${each.value}-DatabaseConnectionsLow-Alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   dimensions = {
#     DBInstanceIdentifier = each.value
#   }
#   datapoints_to_alarm       = 5
#   evaluation_periods        = 5
#   insufficient_data_actions = []
#   ok_actions                = []
#   metric_name               = "DatabaseConnections"
#   namespace                 = "AWS/DocDB"
#   period                    = 60
#   threshold                 = 10
#   unit                      = "Count/Second"
#   statistic                 = "Average"
#   depends_on                = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
#   tags                      = merge(local.tags, { Name : "${each.value}-DatabaseConnectionsLow-Alarm" })
# }
#================ End of CloudWatchAlarm Configurations ============