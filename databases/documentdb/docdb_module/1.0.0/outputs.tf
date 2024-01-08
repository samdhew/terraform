#================ KMS Configurations ===================
output "docdb_kms_alias" {
  description = "Alias of the DocumentDB KMS."
  value       = aws_kms_alias.docdb_kms_alias.name
}

output "docdb_kms_arn" {
  description = "ARN of the DocumentDB KMS."
  value       = aws_kms_key.docdb_kms_key.arn
}
#================ End of KMS Configurations ============

#================ SecretsManager Configurations ===================
output "docdb_secretsmanager_name" {
  description = "Name of the DocumentDB Secret."
  value       = aws_secretsmanager_secret.docdb_secretsmanager_secret.name
}

output "docdb_secretsmanager_arn" {
  description = "ARN of the DocumentDB Secret."
  value       = aws_secretsmanager_secret.docdb_secretsmanager_secret.arn
}
#================ End of SecretsManager Configurations ============

#================ SNS Configurations ===================
output "docdb_sns_name" {
  description = "Name of the DocumentDB Topic."
  value       = aws_sns_topic.docdb_sns_topic.name
}

output "docdb_sns_arn" {
  description = "ARN of the DocumentDB Topic."
  value       = aws_sns_topic.docdb_sns_topic.arn
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
output "docdb_securitygroup_name" {
  description = "Name of the DocumentDB SecurityGroup."
  value       = aws_security_group.docdb_securitygroup_cluster.name
}

output "docdb_securitygroup_id" {
  description = "ID of the DocumentDB SecurityGroup."
  value       = aws_security_group.docdb_securitygroup_cluster.id
}

output "docdb_securitygroup_vpcid" {
  description = "VPC of the DocumentDB SecurityGroup."
  value       = aws_security_group.docdb_securitygroup_cluster.vpc_id
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
output "docdb_subnetgroup_name" {
  description = "Name of the DocumentDB subnetgroup."
  value       = aws_docdb_subnet_group.docdb_subnetgroup_cluster.name
}

output "docdb_subnetgroup_subnets" {
  description = "Subnets of the DocumentDB subnetgroup."
  value       = aws_docdb_subnet_group.docdb_subnetgroup_cluster.subnet_ids
}

# output "docdb_subnetgroup_ids" {
#   description = "IDs of the DocumentDB SubnetGroup."
#   value       = [for a in data.aws_subnet.docdb_subnetgroup_db : a.id]
# }

# output "docdb_subnetgroup_availabilityzones" {
#   description = "Availability Zones of the DocumentDB SubnetGroup."
#   value       = [for a in data.aws_subnet.docdb_subnetgroup_db : a.availability_zone]
# }
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
output "docdb_parametergroup_clustername" {
  description = "Name of the DocumentDB ParameterGroup cluster."
  value       = aws_docdb_cluster_parameter_group.docdb_parametergroup_cluster.name
}

# output "docdb_parametergroup_instancename" {
#   description = "Name of the DocumentDB ParameterGroup instance."
#   value       = aws_docdb_cluster_parameter_group.docdb_parametergroup_instance.name
# }

output "docdb_parametergroup_clusterfamily" {
  description = "Family of the DocumentDB ParameterGroup cluster."
  value       = aws_docdb_cluster_parameter_group.docdb_parametergroup_cluster.family
}

# output "docdb_parametergroup_instancefamily" {
#   description = "Family of the DocumentDB ParameterGroup instance."
#   value       = aws_docdb_cluster_parameter_group.docdb_parametergroup_instance.family
# }
#================ End of ParameterGroup Configurations ============

#================ DocumentDBCluster Configurations ===================
output "docdb_cluster_identifier" {
  description = "Name of the DocumentDB cluster."
  value       = aws_docdb_cluster.docdb_cluster_cluster.cluster_identifier
}

output "docdb_cluster_arn" {
  description = "ARN of the DocumentDB cluster."
  value       = aws_docdb_cluster.docdb_cluster_cluster.arn
}

output "docdb_cluster_resourceid" {
  description = "Resource ID of the DocumentDB cluster."
  value       = aws_docdb_cluster.docdb_cluster_cluster.cluster_resource_id
}

output "docdb_cluster_endpoint" {
  description = "Ednpoint of the DocumentDB cluster."
  value       = aws_docdb_cluster.docdb_cluster_cluster.endpoint
}

output "docdb_cluster_instances" {
  description = "Instances of the DocumentDB cluster."
  value       = aws_docdb_cluster.docdb_cluster_cluster.cluster_members
}

# output "docdb_database_name" {
#   description = "Name of the the DocumentDB's database."
#   value       = aws_docdb_cluster.docdb_cluster_cluster.database_name
# }
#================ End of DocumentDBCluster Configurations ============

#================ Route53Record Configurations ===================
output "docdb_route53_writerendpoint" {
  description = "Writer edpoint for the DocumentDB cluster."
  value       = aws_route53_record.docdb_route53_cname.name
}
#================ End of Route53Record Configurations ============