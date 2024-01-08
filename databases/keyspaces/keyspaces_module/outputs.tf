#================ KMS Configurations ===================
output "keyspaces_kms_alias" {
  description = "Alias of the Keyspaces KMS."
  value       = aws_kms_alias.keyspaces_kms_alias.name
}

output "keyspaces_kms_arn" {
  description = "ARN of the Keyspaces KMS."
  value       = aws_kms_key.keyspaces_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
output "keyspaces_sns_name" {
  description = "Name of the Keyspaces Topic."
  value       = aws_sns_topic.keyspaces_sns_topic.name
}

output "keyspaces_sns_arn" {
  description = "ARN of the Keyspaces Topic."
  value       = aws_sns_topic.keyspaces_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ KeyspacesKeyspace Configurations ===================
output "keyspaces_keyspace_name" {
  description = "Name of the Keyspaces Keyspace."
  value       = aws_keyspaces_keyspace.keyspaces_keyspace.name
}

output "keyspaces_keyspace_arn" {
  description = "ARN of the Keyspaces Keyspace."
  value       = aws_keyspaces_keyspace.keyspaces_keyspace.arn
}
#================ End of KeyspacesKeyspace Configurations ============

#================ Route53Record Configurations ===================
output "keyspaces_route53_writerendpoint" {
  description = "Writer edpoint for the Keyspaces cluster."
  value       = aws_route53_record.keyspaces_route53_cname.name
}
#================ End of Route53Record Configurations ============