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
variable "dms_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.dms_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "dms_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.dms_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "dms_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "dms_securitygroup_vpcid" {
  description = "VPC id where the DMS will be deployed."
  type        = string

  validation {
    condition     = substr(var.dms_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
variable "dms_subnetgroup_subnets" {
  description = "The Subnet Groups's subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
#================ End of SubnetGroup Configurations ============

#================ DMS Instance Configurations ===================
variable "dms_replicationinstance_name" {
  description = "The DMS's replication instance name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "dms_replicationinstance_engine" {
  description = "The DMS's replication instance engine. Valid value is dms."
  type        = string
  default     = "dms"

  validation {
    condition     = contains(["dms"], var.dms_replicationinstance_engine)
    error_message = "Must be dms."
  }
}

variable "dms_replicationinstance_engineversion" {
  description = "The DMS's replication instance engine version. Valid values are 3.4.5 or 3.4.6 or 3.4.7 or 3.5.1."
  type        = string
  default     = "3.4.6"

  validation {
    condition     = contains(["3.4.5", "3.4.6", "3.4.7", "3.5.1"], var.dms_replicationinstance_engineversion)
    error_message = "Must either be 3.4.5 or 3.4.6 or 3.4.7 or 3.5.1."
  }
}

variable "dms_replicationinstance_instanceclass" {
  description = "The DMS's replication instance, instance class. Valid values are dms.t3.medium or dms.c5.large or dms.c5.xlarge or dms.c5.2xlarge or dms.r5.large or dms.r5.xlarge or dms.r5.2xlarge or dms.r6i.large or dms.r6i.xlarge or dms.r6i.2xlarge."
  type        = string
  default     = "dms.t3.medium"

  validation {
    condition     = contains(["dms.t3.medium", "dms.c5.large", "dms.c5.xlarge", "dms.c5.2xlarge", "dms.r5.large", "dms.r5.xlarge", "dms.r5.2xlarge", "dms.r6i.large", "dms.r6i.xlarge", "dms.r6i.2xlarge"], var.dms_replicationinstance_instanceclass)
    error_message = "Must either be dms.t3.medium or dms.c5.large or dms.c5.xlarge or dms.c5.2xlarge or dms.r5.large or dms.r5.xlarge or dms.r5.2xlarge or dms.r6i.large or dms.r6i.xlarge or dms.r6i.2xlarge."
  }
}

variable "dms_replicationinstance_storage" {
  description = "The DMS's replication instance storage size in GB."
  type        = number
  default     = 50

  validation {
    condition     = var.dms_replicationinstance_storage > 20
    error_message = "Replication instance storage size must be greater than 20GB."
  }
}
#================ End of DMS Instance Configurations ============

#================ DMS Endpoint Configurations ===================
variable "dms_replicationendpoint_file" {
  description = "Config file name of the DMS's replication endpoint. The config file must be in the TFCustomResourceConfigs folder. Example: dms_replicationinstance_endpoint.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.dms_replicationendpoint_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}

# variable "dms_replicationendpoint_name" {
#   description = "The DMS's replication endpoint name. The first character must be a letter. Example: tpi"
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_type" {
#   description = "The DMS's replication endpoint type. Valid values are source or target."
#   type        = string
#   default     = "source"

#   validation {
#     condition     = contains(["source", "target"], var.dms_replicationendpoint_type)
#     error_message = "Must either be source or target."
#   }
# }

# variable "dms_replicationendpoint_engine" {
#   description = "The DMS's replication endpoint engine name. Valid values are aurora or aurora-postgresql or azuredb or azure-sql-managed-instance or db2 or db2-zos or docdb or dynamodb or elasticsearch or kafka or kinesis or mariadb or mongodb or mysql or opensearch or oracle or postgres or redshift or s3 or sqlserver or sybase. Please note that some of engine names are available only for target endpoint type."
#   type        = string
#   default     = "aurora"

#   validation {
#     condition     = contains(["aurora", "aurora-postgresql", "azuredb", "azure-sql-managed-instance", "db2", "db2-zos", "docdb", "dynamodb", "elasticsearch", "kafka", "kinesis", "mariadb", "mongodb", "mysql", "opensearch", "oracle", "postgres", "redshift", "s3", "sqlserver", "sybase"], var.dms_replicationendpoint_engine)
#     error_message = "Must either be aurora or aurora-postgresql or azuredb or azure-sql-managed-instance or db2 or db2-zos or docdb or dynamodb or elasticsearch or kafka or kinesis or mariadb or mongodb or mysql or opensearch or oracle or postgres or redshift or s3 or sqlserver or sybase."
#   }
# }

# variable "dms_replicationendpoint_secret" {
#   description = "The DMS's replication endpoint secret. The first character must be a letter. Example: tpi"
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_secretaccessrolearn" {
#   description = "The DMS's replication endpoint secret access role. The first character must be a letter. Example: tpi"
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_server" {
#   description = "The DMS's replication endpoint server. The first character must be a letter. Example: tpi"
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_port" {
#   description = "The DMS's replication endpoint port."
#   type        = number
#   default     = null
# }

# variable "dms_replicationendpoint_database" {
#   description = "The DMS's replication endpoint database."
#   type        = string
#   default     = null

#   validation {
#     condition     = can(regex("^[a-z][0-9a-z_]+$", var.dms_replicationendpoint_database))
#     error_message = "Database name must start with a letter. Value only a-z, 0-9 and _ are allowed."
#   }

#   validation {
#     condition     = length(var.dms_replicationendpoint_database) > 3
#     error_message = "Database name length must be greater than 3."
#   }
# }

# variable "dms_replicationendpoint_username" {
#   description = "The DMS's replication endpoint username."
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_password" {
#   description = "The DMS's replication endpoint password."
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_extraconnectiondetails" {
#   description = "The DMS's replication endpoint extra connection details. Example: useLogMinerReader=N;useBfile=Y;"
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_sslmode" {
#   description = "The DMS's replication endpoint SSL mode. Valid values are none or require or verify-ca or verify-full."
#   type        = string
#   default     = "none"

#   validation {
#     condition     = contains(["none", "require", "verify-ca", "verify-full"], var.dms_replicationendpoint_sslmode)
#     error_message = "Must either be none or require or verify-ca or verify-full."
#   }
# }

# variable "dms_replicationendpoint_certificatearn" {
#   description = "The DMS's replication endpoint certificate."
#   type        = string
#   default     = null
# }

# variable "dms_replicationendpoint_serviceaccessrole" {
#   description = "The DMS's replication endpoint service access role for Dynamodb."
#   type        = string
#   default     = null
# }
#================ End of DMS Endpoint Configurations ============

#================ DMS Task Configurations ===================
variable "dms_replicationtask_create" {
  description = "If true, DMS's replication tasks will be created. Make this true only after creating replication instance and endpoints."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.dms_replicationtask_create)
    error_message = "Must either be true or false."
  }
}

variable "dms_replicationtask_file" {
  description = "Config file name of the DMS's replication task. The config file must be in the TFCustomResourceConfigs folder. Example: dms_replicationinstance_task.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.dms_replicationtask_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}
#================ End of DMS Task Configurations ============

#================ Route53Record Configurations ===================
variable "dms_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============