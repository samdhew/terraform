#================ KMS Configurations ===================
output "dynamodb_kms_alias" {
  description = "Alias of the DynamoDB KMS."
  value       = aws_kms_alias.dynamodb_kms_alias.name
}

output "dynamodb_kms_arn" {
  description = "ARN of the DynamoDB KMS."
  value       = aws_kms_key.dynamodb_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
output "dynamodb_sns_name" {
  description = "Name of the DynamoDB Topic."
  value       = aws_sns_topic.dynamodb_sns_topic.name
}

output "dynamodb_sns_arn" {
  description = "ARN of the DynamoDB Topic."
  value       = aws_sns_topic.dynamodb_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ DynamoDBTable Configurations ===================
output "dynamodb_keyspace_name" {
  description = "Name of the DynamoDB Keyspace."
  value       = aws_dynamodb_keyspace.dynamodb_keyspace.name
}

output "dynamodb_keyspace_arn" {
  description = "ARN of the DynamoDB Keyspace."
  value       = aws_dynamodb_keyspace.dynamodb_keyspace.arn
}
#================ End of DynamoDBTable Configurations ============

#================ Route53Record Configurations ===================
output "dynamodb_route53_writerendpoint" {
  description = "Writer edpoint for the DynamoDB cluster."
  value       = aws_route53_record.dynamodb_route53_cname.name
}
#================ End of Route53Record Configurations ============