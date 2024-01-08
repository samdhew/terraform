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
variable "docdb_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.docdb_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "docdb_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.docdb_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "docdb_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "docdb_securitygroup_vpcid" {
  description = "VPC id where the DocumentDB will be deployed."
  type        = string

  validation {
    condition     = substr(var.docdb_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
variable "docdb_subnetgroup_subnets" {
  description = "The Subnet Groups's subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
# variable "docdb_paramtergroup_family" {
#   type        = map(string)
#   description = "The Parameter Groups's family."
#   default = {
#     "3.6.0" = "docdb3.6"
#     "4.0.0" = "docdb4.0"
#     "5.0.0" = "docdb5.0"
#   }
# }

variable "docdb_parametergroupcluster_file" {
  description = "Config file name of the DocumentDB's ParameterGroup cluster. The config file must be in the TFCustomResourceConfigs folder. Example: docdb_parametergroup_cluster.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.docdb_parametergroupcluster_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}

# variable "docdb_parametergroupinstance_file" {
#   description = "Config file name of the DocumentDB's ParameterGroup instance. The config file must be in the TFCustomResourceConfigs folder. Example: docdb_parametergroup_instance.json"
#   type        = string
#   default     = null

#   # validation {
#   #   condition     = substr(var.docdb_parametergroupinstance_file, 0, 24) == "TFCustomResourceConfigs/"
#   #   error_message = "File path must begin with TFCustomResourceConfigs/."
#   # }
# }
#================ End of ParameterGroup Configurations ============

#================ DocumentDBCluster Configurations ===================
variable "docdb_cluster_name" {
  description = "The DocumentDB's cluster name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "docdb_cluster_engine" {
  description = "The DocumentDB engine type. Valid value is docdb."
  type        = string
  default     = "docdb"

  validation {
    condition     = contains(["docdb"], var.docdb_cluster_engine)
    error_message = "Must be docdb."
  }
}

variable "docdb_cluster_engineversion" {
  description = "The DocumentDB's version. Valid values are 3.6.0 or 4.0.0 or 5.0.0."
  type        = string
  default     = "4.0.0"

  validation {
    condition     = contains(["3.6.0", "4.0.0", "5.0.0"], var.docdb_cluster_engineversion)
    error_message = "Must either be 3.6.0 or 4.0.0 or 5.0.0."
  }
}

variable "docdb_cluster_azs" {
  description = "The DocumentDB's cluster AZs."
  type        = list(any)
  default     = null
}

variable "docdb_database_name" {
  description = "The DocumentDB's database name."
  type        = string

  validation {
    condition     = can(regex("^[a-z][0-9a-z_]+$", var.docdb_database_name))
    error_message = "Database name must start with a letter. Value only a-z, 0-9 and _ are allowed."
  }

  validation {
    condition     = length(var.docdb_database_name) > 3
    error_message = "Database name length must be greater than 3."
  }
}
#================ End of DocumentDBCluster Configurations ============

#================ DocumentDBInstance Configurations ===================
variable "docdb_cluster_instanceclass" {
  description = "The DocumentDB's instance class. Valid values are db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  type        = string
  default     = "db.t3.medium"

  validation {
    condition     = contains(["db.t3.medium", "db.t4g.medium", "db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge"], var.docdb_cluster_instanceclass)
    error_message = "Must either be db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  }
}
#================ End of DocumentDBInstance Configurations ============

#================ Route53Record Configurations ===================
variable "docdb_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============