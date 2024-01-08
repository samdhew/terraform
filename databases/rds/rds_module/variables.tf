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
variable "rds_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.rds_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "rds_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.rds_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "rds_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "rds_securitygroup_vpcid" {
  description = "VPC id where the RDS will be deployed."
  type        = string

  validation {
    condition     = substr(var.rds_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ SubnetGroup Configurations ===================
variable "rds_subnetgroup_subnets" {
  description = "The Subnet Groups's subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
#================ End of SubnetGroup Configurations ============

#================ ParameterGroup Configurations ===================
variable "rds_parametergroupinstance_file" {
  description = "Config file name of the RDS's ParameterGroup instance. The config file must be in the TFCustomResourceConfigs folder. Example: rds_parametergroup_instance.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.rds_parametergroupinstance_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}
#================ End of ParameterGroup Configurations ============

#================ OptionGroup Configurations ===================
variable "rds_optiongroupinstance_file" {
  description = "Config file name of the RDS's OptionGroup instance. The config file must be in the TFCustomResourceConfigs folder. Example: rds_optiongroup_instance.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.rds_parametergroupinstance_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}
#================ End of OptionGroup Configurations ============

#================ RDS Configurations ===================
variable "rds_instance_name" {
  description = "The RDS's instance name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "rds_instance_engine" {
  description = "The RDS's engine type. Valid values are mariadb or mysql or oracle-ee or oracle-ee-cdb or oracle-se2 or oracle-se2-cdb or postgres or sqlserver-ee or sqlserver-se or sqlserver-ex or sqlserver-web."
  type        = string

  validation {
    condition     = contains(["mariadb", "mysql", "oracle-ee", "oracle-ee-cdb", "oracle-se2", "oracle-se2-cdb", "postgres", "sqlserver-ee", "sqlserver-se", "sqlserver-ex", "sqlserver-web"], var.rds_instance_engine)
    error_message = "Must either be mariadb or mysql or oracle-ee or oracle-ee-cdb or oracle-se2 or oracle-se2-cdb or postgres or sqlserver-ee or sqlserver-se or sqlserver-ex or sqlserver-web."
  }
}

variable "rds_instance_engineversion" {
  description = "The rds MariaDB's valid values are 10.3.39 or 10.4.30 or 10.5.21 or 10.6.14 or 10.11.4. The rds MySQL's valid values are 5.7.43 or 8.0.34. The rds Oracle EE's valid values are 19.0.0.0.ru-2019-07.rur-2019-07.r1 or 19.0.0.0.ru-2020-10.rur-2020-10.r1 or 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1. The rds Oracle EE-CDB's valid values are 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1 or 21.0.0.0.ru-2022-10.rur-2022-10.r1 or 21.0.0.0.ru-2023-07.rur-2023-07.r1. The rds Oracle SE2's valid values are 19.0.0.0.ru-2019-10.rur-2019-10.r1 or 19.0.0.0.ru-2020-10.rur-2020-10.r1 or 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1. The rds Oracle SE2-CDB's valid values are 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1 or 21.0.0.0.ru-2022-10.rur-2022-10.r1 or 21.0.0.0.ru-2023-07.rur-2023-07.r1. The rds PostgreSQL's valid values are 11.20 or 12.15 or 13.11 or 14.8 or 15.3. The rds SQL Server EE's valid values are 12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1. The rds SQL Server SE's valid values are 12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1. The rds SQL Server EX's valid values are 12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1. The rds SQL Server Web's valid values are 12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1. "
  type        = string

  validation {
    condition     = contains(["10.3.39", "10.4.30", "10.5.21", "10.6.14", "10.11.4", "5.7.43", "8.0.34", "19.0.0.0.ru-2019-07.rur-2019-07.r1", "19.0.0.0.ru-2020-10.rur-2020-10.r1", "19.0.0.0.ru-2021-10.rur-2021-10.r1", "19.0.0.0.ru-2022-10.rur-2022-10.r1", "19.0.0.0.ru-2023-07.rur-2023-07.r1", "19.0.0.0.ru-2021-10.rur-2021-10.r1", "19.0.0.0.ru-2022-10.rur-2022-10.r1", "19.0.0.0.ru-2023-07.rur-2023-07.r1", "21.0.0.0.ru-2022-10.rur-2022-10.r1", "21.0.0.0.ru-2023-07.rur-2023-07.r1", "19.0.0.0.ru-2019-10.rur-2019-10.r1", "19.0.0.0.ru-2020-10.rur-2020-10.r1", "19.0.0.0.ru-2021-10.rur-2021-10.r1", "19.0.0.0.ru-2022-10.rur-2022-10.r1", "19.0.0.0.ru-2023-07.rur-2023-07.r1", "19.0.0.0.ru-2021-10.rur-2021-10.r1", "19.0.0.0.ru-2022-10.rur-2022-10.r1", "19.0.0.0.ru-2023-07.rur-2023-07.r1", "21.0.0.0.ru-2022-10.rur-2022-10.r1", "21.0.0.0.ru-2023-07.rur-2023-07.r1", "11.20", "12.15", "13.11", "14.8", "15.3", "12.00.6444.4.v1", "13.00.6430.49.v1", "14.00.3460.9.v1", "15.00.4316.3.v1", "12.00.6444.4.v1", "13.00.6430.49.v1", "14.00.3460.9.v1", "15.00.4316.3.v1", "12.00.6444.4.v1", "13.00.6430.49.v1", "14.00.3460.9.v1", "15.00.4316.3.v1", "12.00.6444.4.v1", "13.00.6430.49.v1", "14.00.3460.9.v1", "15.00.4316.3.v1"], var.rds_instance_engineversion)
    error_message = "Must either be rds MariaDB [10.3.39 or 10.4.30 or 10.5.21 or 10.6.14 or 10.11.4] or MySQL [5.7.43 or 8.0.34] or Oracle EE [19.0.0.0.ru-2019-07.rur-2019-07.r1 or 19.0.0.0.ru-2020-10.rur-2020-10.r1 or 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1] or Oracle EE-CDB [19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1 or 21.0.0.0.ru-2022-10.rur-2022-10.r1 or 21.0.0.0.ru-2023-07.rur-2023-07.r1] or Oracle SE2 [19.0.0.0.ru-2019-10.rur-2019-10.r1 or 19.0.0.0.ru-2020-10.rur-2020-10.r1 or 19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1] or Oracle SE2-CDB [19.0.0.0.ru-2021-10.rur-2021-10.r1 or 19.0.0.0.ru-2022-10.rur-2022-10.r1 or 19.0.0.0.ru-2023-07.rur-2023-07.r1 or 21.0.0.0.ru-2022-10.rur-2022-10.r1 or 21.0.0.0.ru-2023-07.rur-2023-07.r1] or PostgreSQL [11.20 or 12.15 or 13.11 or 14.8 or 15.3] or SQL Server EE [12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1] or SQL Server SE [12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1] or SQL Server EX [12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1] or SQL Server Web [12.00.6444.4.v1 or 13.00.6430.49.v1 or 14.00.3460.9.v1 or 15.00.4316.3.v1]."
  }
}

variable "rds_instance_enginelicensemodel" {
  description = "The rds MariaDB's valid value is general-public-license. The rds MySQL's valid value is general-public-license. The rds Oracle's valid values are bring-your-own-license or license-included. The rds PostgreSQL's valid value is postgresql-license. The rds SQL Server's valid value is license-included."
  type        = string

  validation {
    condition     = contains(["general-public-license", "license-included", "bring-your-own-license", "postgresql-license"], var.rds_instance_enginelicensemodel)
    error_message = "Must either be rds MariaDB [general-public-license] or MySQL [general-public-license] or Oracle [bring-your-own-license or license-included] or PostgreSQL [postgresql-license] or SQL Server [license-included]."
  }
}

variable "rds_instance_instanceclass" {
  description = "The RDS's instance class. Valid values are db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  type        = string
  default     = "db.t3.medium"

  validation {
    condition     = contains(["db.t3.medium", "db.t4g.medium", "db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge"], var.rds_instance_instanceclass)
    error_message = "Must either be db.t3.medium or db.t4g.medium or db.r5.large or db.r5.xlarge or db.r5.2xlarge or db.r6g.large or db.r6g.xlarge or db.r6g.2xlarge."
  }
}

variable "rds_storage_allocated" {
  description = "The RDS's storage allocated size in GB."
  type        = number
  default     = 50

  validation {
    condition     = var.rds_storage_allocated > 20
    error_message = "RDS storage size must be greater than 20GB."
  }
}

variable "rds_storage_maxallocated" {
  description = "The RDS's maximum storage allocated size for auto scalling in GB."
  type        = number
  default     = 100
}

variable "rds_storage_type" {
  description = "The RDS's storage type. Valid values are gp2 or gp3 or io1 or standard."
  type        = string
  default     = "gp2"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "standard"], var.rds_storage_type)
    error_message = "Must either be gp2 or gp3 or io1 or standard."
  }
}

variable "rds_storage_iops" {
  description = "The RDS's storage IOPs."
  type        = number
  default     = 100
}

variable "rds_database_name" {
  description = "The RDS's database name."
  type        = string

  validation {
    condition     = can(regex("^[a-z][0-9a-z]+$", var.rds_database_name))
    error_message = "Database name must start with a letter. Value only a-z and 0-9 are allowed."
  }

  validation {
    condition     = length(var.rds_database_name) > 3
    error_message = "Database name length must be greater than 3."
  }
}

variable "rds_instance_characterset" {
  description = "The RDS's character set (collation) for Oracle or SQL Server. Valid values are in Oracle [https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html#Appendix.OracleCharacterSets.db-character-set] or SQL Server [https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.SQLServer.CommonDBATasks.Collation.html]."
  type        = string
  default     = null
}

variable "rds_instance_ncharcharacterset" {
  description = "The RDS's national character set for Oracle. Valid values are in https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html#Appendix.OracleCharacterSets.nchar-character-set."
  type        = string
  default     = null
}

variable "rds_instance_timezone" {
  description = "The RDS's timezone for SQL Server. Valid values are in https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone."
  type        = string
  default     = "Eastern Standard Time"
}

variable "rds_instance_replicamode" {
  description = "The RDS's replica mode for Oracle. Valid values are mounted or open-read-only."
  type        = string
  default     = "open-read-only"

  validation {
    condition     = contains(["mounted", "open-read-only"], var.rds_instance_replicamode)
    error_message = "Must either be mounted or open-read-only."
  }
}
#================ End of RDS Configurations ============

#================ Route53Record Configurations ===================
variable "rds_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============