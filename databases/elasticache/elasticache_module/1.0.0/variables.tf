#================ Common Tags ========================
variable "mandatory_tags" {
  type        = map(string)
  description = " A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  validation {
    condition     = length(lookup(var.mandatory_tags, "t_AppID", "")) > 6 && length(lookup(var.mandatory_tags, "t_environment", "")) >= 2 && (length(lookup(var.mandatory_tags, "t_dcl", "")) == 1 || length(lookup(var.mandatory_tags, "t_dcl", "")) == 4)
    error_message = "Tags must contain at least these non-empty keys: t_dcl, t_AppID, and t_environment."
  }
  validation {
    condition     = substr(lookup(var.mandatory_tags, "t_AppID"), 0, 3) == "SVC"
    error_message = "Tag t_AppID must begin with SVC."
  }
  validation {
    condition     = contains(keys(var.mandatory_tags), "t_AppName")
    error_message = "Tags must contain the key: t_AppName."
  }
  validation {
    condition     = contains(keys(var.mandatory_tags), "t_environment")
    error_message = "Tags must contain the key: t_environment."
  }
  validation {
    condition = contains([
      "PRD", "DEV", "QA", "TST", "PRF", "STG", "POC", "DR", "PPE", "SMK", "PV", "UAT", "INT", "ACP", "IVV", "NONPRD",
      "DEMO", "SEC", "BETA"
    ], lookup(var.mandatory_tags, "t_environment"))
    error_message = "Tag t_environment must be one of the following: PRD, DEV, QA, TST, PRF, STG, POC, DR, PPE, SMK, PV, UAT, INT, ACP, IVV, NONPRD, DEMO, SEC, or BETA."
  }
  validation {
    condition     = contains(["1", "2", "3", "DCL1", "DCL2", "DCL3"], lookup(var.mandatory_tags, "t_dcl"))
    error_message = "Tag t_dcl must be one of the following: 1, 2, 3, DCL1, DCL2, or DCL3."
  }
}

variable "default_tags" {
  description = "Default tags to add to all resources."
  type        = map(string)
  default = {
    terraform    = "yes"
    module_owner = "srepod8"
  }
}
#================ End of Common Tags =================

#================ IAM Configurations ===================
variable "iam_customepolicy_file" {
  description = "Policy file name for the IAM custom policy. This file must reside within TFCustomResourceConfigs folder."
  type        = string
  default     = "iam_custompolicy.json"

  validation {
    condition     = substr(var.iam_customepolicy_file, -5, -1) == ".json"
    error_message = "File must end with json extension."
  }
}
#================ End of IAM Configurations ============

#================ KMS Configurations ===================
variable "elasticache_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.elasticache_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "elasticache_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.elasticache_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "elasticache_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "elasticache_securitygroup_vpcid" {
  description = "VPC id where the Elasticache Memcached/Redis will be deployed."
  type        = string

  validation {
    condition     = substr(var.elasticache_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
variable "elasticache_subnetgroup_subnets" {
  description = "The Subnet Groups's subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
variable "elasticache_parametergroupcluster_file" {
  description = "Config file name of the Elasticache Memcached/Redis's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: redis_parametergroup_cluster.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.elasticache_parametergroupcluster_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}
#================ End of ParameterGroup Configurations ============

#================ ReplicationGroup Configurations ===================

#================ End of ReplicationGroup Configurations ============

#================ ElasticacheCluster Configurations ===================
variable "elasticache_cluster_name" {
  description = "The Elasticache Memcached/Redis's cluster name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "elasticache_cluster_engine" {
  description = "The Elasticache engine type. Valid values are elasticache-memcached or elasticache-redis."
  type        = string

  validation {
    condition     = contains(["elasticache-memcached", "elasticache-redis"], var.elasticache_cluster_engine)
    error_message = "Must be elasticache-memcached or elasticache-redis."
  }
}

variable "elasticache_cluster_engineversion" {
  description = "The Elasticache Memcached's valid values are 1.4.34 or 1.5.16 or 1.6.17. The Elasticache Redis's valid values are 4.0.10 or 5.0.6 or 6.2 or 7.0"
  type        = string

  validation {
    condition     = contains(["1.4.34", "1.5.16", "1.6.17", "4.0.10", "5.0.6", "6.2", "7.0"], var.elasticache_cluster_engineversion)
    error_message = "Must either be Elasticache Memcached [1.4.34 or 1.5.16 or 1.6.17] or Elasticache Redis [4.0.10 or 5.0.6 or 6.2 or 7.0]."
  }
}

variable "elasticache_cluster_azs" {
  description = "The Elasticache Memcached/Redis's cluster AZs."
  type        = list(any)
  default     = null
}

variable "elasticache_cluster_instanceclass" {
  description = "The Elasticache Memcached/Redis's instance class. Valid values are cache.t3.medium or cache.t4g.medium or cache.r5.large or cache.r5.xlarge or cache.r5.2xlarge or cache.r6g.large or cache.r6g.xlarge or cache.r6g.2xlarge."
  type        = string
  default     = "cache.t3.medium"

  validation {
    condition     = contains(["cache.t3.medium", "cache.t4g.medium", "cache.r5.large", "cache.r5.xlarge", "cache.r5.2xlarge", "cache.r6g.large", "cache.r6g.xlarge", "cache.r6g.2xlarge"], var.elasticache_cluster_instanceclass)
    error_message = "Must either be cache.t3.medium or cache.t4g.medium or cache.r5.large or cache.r5.xlarge or cache.r5.2xlarge or cache.r6g.large or cache.r6g.xlarge or cache.r6g.2xlarge."
  }
}
#================ End of ElasticacheCluster Configurations ============

#================ Route53Record Configurations ===================
variable "elasticache_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============