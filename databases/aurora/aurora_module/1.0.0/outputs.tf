#================ KMS Configurations ===================
output "aurora_kms_alias" {
  description = "Alias of the Aurora PostgreSQL/MySQL KMS."
  value       = aws_kms_alias.aurora_kms_alias.name
}

output "aurora_kms_arn" {
  description = "ARN of the Aurora PostgreSQL/MySQL KMS."
  value       = aws_kms_key.aurora_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SecretsManager Configurations ===================
output "aurora_secretsmanager_name" {
  description = "Name of the Aurora PostgreSQL/MySQL Secret."
  value       = aws_secretsmanager_secret.aurora_secretsmanager_secret.name
}

output "aurora_secretsmanager_arn" {
  description = "ARN of the Aurora PostgreSQL/MySQL Secret."
  value       = aws_secretsmanager_secret.aurora_secretsmanager_secret.arn
}
#================ End of SecretsManager Configurations ============

#================ SNS Configurations ===================
output "aurora_sns_name" {
  description = "Name of the Aurora PostgreSQL/MySQL Topic."
  value       = aws_sns_topic.aurora_sns_topic.name
}

output "aurora_sns_arn" {
  description = "ARN of the Aurora PostgreSQL/MySQL Topic."
  value       = aws_sns_topic.aurora_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
output "aurora_securitygroup_name" {
  description = "Name of the Aurora PostgreSQL/MySQL SecurityGroup."
  value       = aws_security_group.aurora_securitygroup_cluster.name
}

output "aurora_securitygroup_id" {
  description = "ID of the Aurora PostgreSQL/MySQL SecurityGroup."
  value       = aws_security_group.aurora_securitygroup_cluster.id
}

output "aurora_securitygroup_vpcid" {
  description = "VPC of the Aurora PostgreSQL/MySQL SecurityGroup."
  value       = aws_security_group.aurora_securitygroup_cluster.vpc_id
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
output "aurora_subnetgroup_name" {
  description = "Name of the Aurora PostgreSQL/MySQL SubnetGroup."
  value       = aws_db_subnet_group.aurora_subnetgroup_cluster.name
}

output "aurora_subnetgroup_subnets" {
  description = "Subnets of the Aurora PostgreSQL/MySQL SubnetGroup."
  value       = aws_db_subnet_group.aurora_subnetgroup_cluster.subnet_ids
}

# output "aurora_subnetgroup_ids" {
#   description = "IDs of the Aurora PostgreSQL/MySQL SubnetGroup."
#   value       = [for a in data.aws_subnet.aurora_subnetgroup_db : a.id]
# }

# output "aurora_subnetgroup_availabilityzones" {
#   description = "Availability Zones of the Aurora PostgreSQL/MySQL SubnetGroup."
#   value       = [for a in data.aws_subnet.aurora_subnetgroup_db : a.availability_zone]
# }
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
output "aurora_parametergroup_clustername" {
  description = "Name of the Aurora PostgreSQL/MySQL ParameterGroup cluster."
  value       = aws_rds_cluster_parameter_group.aurora_parametergroup_cluster.name
}

output "aurora_parametergroup_instancename" {
  description = "Name of the Aurora PostgreSQL/MySQL ParameterGroup instance."
  value       = aws_db_parameter_group.aurora_parametergroup_instance.name
}

output "aurora_parametergroup_clusterfamily" {
  description = "Family of the Aurora PostgreSQL/MySQL ParameterGroup cluster."
  value       = aws_rds_cluster_parameter_group.aurora_parametergroup_cluster.family
}

output "aurora_parametergroup_instancefamily" {
  description = "Family of the Aurora PostgreSQL/MySQL ParameterGroup instance."
  value       = aws_db_parameter_group.aurora_parametergroup_instance.family
}
#================ End of ParameterGroup Configurations ============

#================ AuroraPostgreSQLCluster Configurations ===================
output "aurora_cluster_identifier" {
  description = "Name of the Aurora PostgreSQL/MySQL cluster."
  value       = aws_rds_cluster.aurora_cluster_cluster.cluster_identifier
}

output "aurora_cluster_arn" {
  description = "ARN of the Aurora PostgreSQL/MySQL cluster."
  value       = aws_rds_cluster.aurora_cluster_cluster.arn
}

output "aurora_cluster_resourceid" {
  description = "Resource ID of the Aurora PostgreSQL/MySQL cluster."
  value       = aws_rds_cluster.aurora_cluster_cluster.cluster_resource_id
}

output "aurora_cluster_endpoint" {
  description = "Endpoint of the Aurora PostgreSQL/MySQL cluster."
  value       = aws_rds_cluster.aurora_cluster_cluster.endpoint
}

output "aurora_cluster_instances" {
  description = "Instances of the Aurora PostgreSQL/MySQL cluster."
  value       = aws_rds_cluster.aurora_cluster_cluster.cluster_members
}

output "aurora_database_name" {
  description = "Name of the the Aurora PostgreSQL/MySQL's database."
  value       = aws_rds_cluster.aurora_cluster_cluster.database_name
}
#================ End of AuroraPostgreSQLCluster Configurations ============

#================ Route53Record Configurations ===================
output "aurora_route53_writerendpoint" {
  description = "Writer edpoint for the Aurora PostgreSQL/MySQL cluster."
  value       = aws_route53_record.aurora_route53_cname.name
}
#================ End of Route53Record Configurations ============