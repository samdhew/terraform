#================ KMS Configurations ===================
output "elasticache_kms_alias" {
  description = "Alias of the Elasticache Memcached/Redis KMS."
  value       = aws_kms_alias.elasticache_kms_alias.name
}

output "elasticache_kms_arn" {
  description = "ARN of the Elasticache Memcached/Redis KMS."
  value       = aws_kms_key.elasticache_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SecretsManager Configurations ===================
output "elasticache_secretsmanager_adminname" {
  description = "Name of the Elasticache Memcached/Redis Admin Secret."
  value       = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.name
}

output "elasticache_secretsmanager_adminarn" {
  description = "ARN of the Elasticache Memcached/Redis Admin Secret."
  value       = aws_secretsmanager_secret.elasticache_secretsmanager_adminsecret.arn
}

output "elasticache_secretsmanager_appname" {
  description = "Name of the Elasticache Memcached/Redis App Secret."
  value       = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.name
}

output "elasticache_secretsmanager_apparn" {
  description = "ARN of the Elasticache Memcached/Redis App Secret."
  value       = aws_secretsmanager_secret.elasticache_secretsmanager_appsecret.arn
}
#================ End of SecretsManager Configurations ============

#================ SNS Configurations ===================
output "elasticache_sns_name" {
  description = "Name of the Elasticache Memcached/Redis Topic."
  value       = aws_sns_topic.elasticache_sns_topic.name
}

output "elasticache_sns_arn" {
  description = "ARN of the Elasticache Memcached/Redis Topic."
  value       = aws_sns_topic.elasticache_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
output "elasticache_securitygroup_name" {
  description = "Name of the Elasticache Memcached/Redis SecurityGroup."
  value       = aws_security_group.elasticache_securitygroup_cluster.name
}

output "elasticache_securitygroup_id" {
  description = "ID of the Elasticache Memcached/Redis SecurityGroup."
  value       = aws_security_group.elasticache_securitygroup_cluster.id
}

output "elasticache_securitygroup_vpcid" {
  description = "VPC of the Elasticache Memcached/Redis SecurityGroup."
  value       = aws_security_group.elasticache_securitygroup_cluster.vpc_id
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
output "elasticache_subnetgroup_name" {
  description = "Name of the Elasticache Memcached/Redis subnetgroup."
  value       = aws_elasticache_subnet_group.elasticache_subnetgroup_cluster.name
}

output "elasticache_subnetgroup_subnets" {
  description = "Subnets of the Elasticache Memcached/Redis subnetgroup."
  value       = aws_elasticache_subnet_group.elasticache_subnetgroup_cluster.subnet_ids
}
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
output "elasticache_parametergroup_clustername" {
  description = "Name of the Elasticache Memcached/Redis ParameterGroup cluster."
  value       = aws_elasticache_parameter_group.elasticache_parametergroup_cluster.name
}

output "elasticache_parametergroup_clusterfamily" {
  description = "Family of the Elasticache Memcached/Redis ParameterGroup cluster."
  value       = aws_elasticache_parameter_group.elasticache_parametergroup_cluster.family
}
#================ End of ParameterGroup Configurations ============

#================ ReplicationGroup Configurations ===================

#================ End of ReplicationGroup Configurations ============

#================ ElasticacheCluster Configurations ===================
output "elasticache_cluster_identifier" {
  description = "Name of the Elasticache Memcached/Redis cluster."
  value       = aws_elasticache_cluster.elasticache_cluster_cluster.cluster_id
}

output "elasticache_cluster_arn" {
  description = "ARN of the Elasticache Memcached/Redis cluster."
  value       = aws_elasticache_cluster.elasticache_cluster_cluster.arn
}

output "elasticache_cluster_endpoint" {
  description = "Ednpoint of the Elasticache Memcached/Redis cluster."
  value       = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? [aws_elasticache_cluster.elasticache_cluster_cluster.cluster_address] : [trimsuffix(aws_elasticache_replication_group.elasticache_replicationgroup_cluster[0].primary_endpoint_address, ":6379")]
}

output "elasticache_cluster_instances" {
  description = "Instances of the Elasticache Memcached/Redis cluster."
  value       = aws_elasticache_cluster.elasticache_cluster_cluster.cache_nodes
}
#================ End of ElasticacheCluster Configurations ============

#================ Route53Record Configurations ===================
output "elasticache_route53_writerendpoint" {
  description = "Writer edpoint for the Elasticache Memcached/Redis cluster."
  value       = aws_route53_record.elasticache_route53_cname.name
}
#================ End of Route53Record Configurations ============