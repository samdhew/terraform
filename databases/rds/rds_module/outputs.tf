# #================ KMS Configurations ===================
# output "rds_kms_alias" {
#   description = "Alias of the RDS KMS."
#   value       = aws_kms_alias.rds_kms_alias.name
# }

# output "rds_kms_arn" {
#   description = "ARN of the RDS KMS."
#   value       = aws_kms_key.rds_kms_key.arn
# }
# #================ End of KMS Configurations ============

# #================ SecretsManager Configurations ===================
# output "rds_secretsmanager_name" {
#   description = "Name of the RDS Secret."
#   value       = aws_secretsmanager_secret.rds_secretsmanager_secret.name
# }

# output "rds_secretsmanager_arn" {
#   description = "ARN of the RDS Secret."
#   value       = aws_secretsmanager_secret.rds_secretsmanager_secret.arn
# }
# #================ End of SecretsManager Configurations ============

# #================ SNS Configurations ===================
# output "rds_sns_name" {
#   description = "Name of the RDS Topic."
#   value       = aws_sns_topic.rds_sns_topic.name
# }

# output "rds_sns_arn" {
#   description = "ARN of the RDS Topic."
#   value       = aws_sns_topic.rds_sns_topic.arn
# }
# #================ End of SNS Configurations ============

# #================ SecurityGroup Configurations ===================
# output "rds_securitygroup_name" {
#   description = "Name of the RDS SecurityGroup."
#   value       = aws_security_group.rds_securitygroup_cluster.name
# }

# output "rds_securitygroup_id" {
#   description = "ID of the RDS SecurityGroup."
#   value       = aws_security_group.rds_securitygroup_cluster.id
# }

# output "rds_securitygroup_vpcid" {
#   description = "VPC of the RDS SecurityGroup."
#   value       = aws_security_group.rds_securitygroup_cluster.vpc_id
# }
# #================ End of SecurityGroup Configurations ============

# #================ SubnetGroup Configurations ===================
# output "rds_subnetgroup_name" {
#   description = "Name of the RDS SubnetGroup."
#   value       = aws_db_subnet_group.rds_subnetgroup_cluster.name
# }

# output "rds_subnetgroup_subnets" {
#   description = "Subnets of the RDS SubnetGroup."
#   value       = aws_db_subnet_group.rds_subnetgroup_cluster.subnet_ids
# }

# # output "rds_subnetgroup_ids" {
# #   description = "IDs of the RDS SubnetGroup."
# #   value       = [for a in data.aws_subnet.rds_subnetgroup_db : a.id]
# # }

# # output "rds_subnetgroup_availabilityzones" {
# #   description = "Availability Zones of the RDS SubnetGroup."
# #   value       = [for a in data.aws_subnet.rds_subnetgroup_db : a.availability_zone]
# # }
# #================ End of SubnetGroup Configurations ============

# #================ ParameterGroup Configurations ===================
# output "rds_parametergroup_clustername" {
#   description = "Name of the RDS ParameterGroup cluster."
#   value       = aws_rds_cluster_parameter_group.rds_parametergroup_cluster.name
# }

# output "rds_parametergroup_instancename" {
#   description = "Name of the RDS ParameterGroup instance."
#   value       = aws_db_parameter_group.rds_parametergroup_instance.name
# }

# output "rds_parametergroup_clusterfamily" {
#   description = "Family of the RDS ParameterGroup cluster."
#   value       = aws_rds_cluster_parameter_group.rds_parametergroup_cluster.family
# }

# output "rds_parametergroup_instancefamily" {
#   description = "Family of the RDS ParameterGroup instance."
#   value       = aws_db_parameter_group.rds_parametergroup_instance.family
# }
# #================ End of ParameterGroup Configurations ============

# #================ RDS Configurations ===================
# output "rds_cluster_identifier" {
#   description = "Name of the RDS cluster."
#   value       = aws_rds_cluster.rds_cluster_cluster.cluster_identifier
# }

# output "rds_cluster_arn" {
#   description = "ARN of the RDS cluster."
#   value       = aws_rds_cluster.rds_cluster_cluster.arn
# }

# output "rds_cluster_resourceid" {
#   description = "Resource ID of the RDS cluster."
#   value       = aws_rds_cluster.rds_cluster_cluster.cluster_resource_id
# }

# output "rds_cluster_endpoint" {
#   description = "Endpoint of the RDS cluster."
#   value       = aws_rds_cluster.rds_cluster_cluster.endpoint
# }

# output "rds_cluster_instances" {
#   description = "Instances of the RDS cluster."
#   value       = aws_rds_cluster.rds_cluster_cluster.cluster_members
# }

# output "rds_database_name" {
#   description = "Name of the the RDS's database."
#   value       = aws_rds_cluster.rds_cluster_cluster.database_name
# }
# #================ End of RDS Configurations ============

# #================ Route53Record Configurations ===================
# output "rds_route53_writerendpoint" {
#   description = "Writer edpoint for the RDS cluster."
#   value       = aws_route53_record.rds_route53_cname.name
# }
# #================ End of Route53Record Configurations ============