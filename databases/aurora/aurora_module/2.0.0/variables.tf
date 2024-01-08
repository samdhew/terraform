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
#================ IAM of KMS Configurations ============

#================ KMS Configurations ===================
variable "aurora_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.aurora_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "aurora_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.aurora_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "aurora_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "aurora_securitygroup_vpcid" {
  description = "VPC id where the Aurora PostgreSQL/MySQL will be deployed."
  type        = string

  validation {
    condition     = substr(var.aurora_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
variable "aurora_subnetgroup_subnets" {
  description = "The Subnet Groups's subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
variable "aurora_parametergroupcluster_file" {
  description = "Config file name of the Aurora PostgreSQL/MySQL's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: aurorapgsql_parametergroup_cluster.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.aurora_parametergroupcluster_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}

variable "aurora_parametergroupinstance_file" {
  description = "Config file name of the Aurora PostgreSQL/MySQL's ParameterGroup instance. The config file must be in the TFCustomResourceConfigs folder. Example: aurorapgsql_parametergroup_instance.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.aurora_parametergroupinstance_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}
#================ End of ParameterGroup Configurations ============

#================ AuroraPostgreSQLCluster Configurations ===================
variable "aurora_cluster_name" {
  description = "The Aurora PostgreSQL/MySQL's cluster name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "aurora_cluster_engine" {
  description = "The Aurora engine type. Valid values are aurora-mysql or aurora-postgresql or mysql or postgres."
  type        = string

  validation {
    condition     = contains(["aurora-mysql", "aurora-postgresql", "mysql", "postgres"], var.aurora_cluster_engine)
    error_message = "Must either be aurora-mysql or aurora-postgresql or mysql or postgres."
  }
}

variable "aurora_cluster_engineversion" {
  description = "The Aurora MySQL's valid values are 2.11.3 or 2.12.0 or 3.01.1 or 3.02.3 or 3.03.1 or 3.04.0. The Aurora PostgreSQL's valid values are 13.11 or 14.8 or 15.3."
  type        = string

  validation {
    condition     = contains(["2.11.3", "2.12.0", "3.01.1", "3.02.3", "3.03.1", "3.04.0", "13.11", "14.8", "15.3"], var.aurora_cluster_engineversion)
    error_message = "Must either be Aurora MySQL [2.11.3 or 2.12.0 or 3.01.1 or 3.02.3 or 3.03.1 or 3.04.0] or Aurora PostgreSQL [13.11 or 14.8 or 15.3]."
  }
}

variable "aurora_cluster_azs" {
  description = "The Aurora PostgreSQL/MySQL's cluster AZs."
  type        = list(any)
  default     = null
}

variable "aurora_database_name" {
  description = "The Aurora PostgreSQL/MySQL's database name."
  type        = string

  validation {
    condition     = can(regex("^[a-z][0-9a-z_]+$", var.aurora_database_name))
    error_message = "Database name must start with a letter. Value only a-z and 0-9 are allowed."
  }

  validation {
    condition     = length(var.aurora_database_name) > 3
    error_message = "Database name length must be greater than 3."
  }
}
#================ End of AuroraPostgreSQLCluster Configurations ============

#================ AuroraPostgreSQLInstance Configurations ===================
variable "aurora_cluster_instanceclass" {
  description = "The Aurora PostgreSQL/MySQL's instance class. Valid values are db.serverless or db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  type        = string
  default     = "db.t3.medium"

  validation {
    condition     = contains(["db.serverless", "db.t3.medium", "db.t4g.medium", "db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge"], var.aurora_cluster_instanceclass)
    error_message = "Must either be db.serverless or db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  }
}
#================ End of AuroraPostgreSQLInstance Configurations ============

#================ Route53Record Configurations ===================
variable "aurora_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============