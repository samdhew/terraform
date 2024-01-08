#================ KMS Configurations ===================
output "ec2database_kms_alias" {
  description = "Alias of the EC2 backed database server KMS."
  value       = aws_kms_alias.ec2database_kms_alias.name
}

output "ec2database_kms_arn" {
  description = "ARN of the EC2 backed database server KMS."
  value       = aws_kms_key.ec2database_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SecretsManager Configurations ===================
output "ec2database_secretsmanager_sshkeyname" {
  description = "Name of the EC2 backed database server SSH Key Secret."
  value       = aws_secretsmanager_secret.ec2database_secretsmanager_secretsshkey.name
}

output "ec2database_secretsmanager_sshkeyarn" {
  description = "ARN of the EC2 backed database server SSH Key Secret."
  value       = aws_secretsmanager_secret.ec2database_secretsmanager_secretsshkey.arn
}

output "ec2database_secretsmanager_adminname" {
  description = "Name of the EC2 backed database server Admin Secret."
  value       = aws_secretsmanager_secret.ec2database_secretsmanager_secretadmin.name
}

output "ec2database_secretsmanager_adminarn" {
  description = "ARN of the EC2 backed database server Admin Secret."
  value       = aws_secretsmanager_secret.ec2database_secretsmanager_secretadmin.arn
}
#================ End of SecretsManager Configurations ============

#================ ParameterStore Configurations ===================
output "ec2database_parameterstore_sshkeyname" {
  description = "Name of the EC2 backed database server SSH Key parameter."
  value       = aws_ssm_parameter.ec2database_parameterstore_parametersshkey.name
}
#================ End of ParameterStore Configurations ============

#================ SNS Configurations ===================
output "ec2database_sns_name" {
  description = "Name of the EC2 backed database server Topic."
  value       = aws_sns_topic.ec2database_sns_topic.name
}

output "ec2database_sns_arn" {
  description = "ARN of the EC2 backed database server Topic."
  value       = aws_sns_topic.ec2database_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
output "ec2database_securitygroup_name" {
  description = "Name of the EC2 backed database server SecurityGroup."
  value       = aws_security_group.ec2database_securitygroup_ec2.name
}

output "ec2database_securitygroup_id" {
  description = "ID of the EC2 backed database server SecurityGroup."
  value       = aws_security_group.ec2database_securitygroup_ec2.id
}

output "ec2database_securitygroup_vpcid" {
  description = "VPC of the EC2 backed database server SecurityGroup."
  value       = aws_security_group.ec2database_securitygroup_ec2.vpc_id
}
#================ End of SecurityGroup Configurations ============

#================ EC2BackedDatabase Configurations ===================
# output "ec2database_cluster_identifier" {
#   description = "Name of the EC2 backed database server cluster."
#   value       = aws_instance.ec2database_cluster_instance[*].cluster_identifier
# }

output "ec2database_cluster_arn" {
  description = "ARN of the EC2 backed database server cluster."
  value       = aws_instance.ec2database_cluster_instance[*].arn
}

output "ec2database_cluster_privateipv4" {
  description = "Private IPv4 of the EC2 backed database server cluster."
  value       = aws_instance.ec2database_cluster_instance[*].private_ip
}

output "ec2database_cluster_privatedns" {
  description = "Private DNS of the EC2 backed database server cluster."
  value       = aws_instance.ec2database_cluster_instance[*].private_dns
}
#================ End of EC2BackedDatabase Configurations ============

#================ Route53Record Configurations ===================
# output "ec2database_route53_writerendpoint" {
#   description = "Writer edpoint for the EC2 backed database server cluster."
#   value       = aws_route53_record.ec2database_route53_cname.name
# }
#================ End of Route53Record Configurations ============