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
variable "dynamodb_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.dynamodb_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "dynamodb_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.dynamodb_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "dynamodb_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ KeyspacesKeyspace Configurations ===================
variable "dynamodb_keyspace_name" {
  description = "The DynamoDB's Keyspace name. The first character must be a letter. Example: gradebook"
  type        = string

  validation {
    condition     = can(regex("^[a-z][0-9a-z_]+$", var.dynamodb_keyspace_name))
    error_message = "Keyspace name must start with a letter. Value only a-z and 0-9 are allowed."
  }

  validation {
    condition     = length(var.dynamodb_keyspace_name) > 3
    error_message = "Keyspace name length must be greater than 3."
  }
}
#================ End of KeyspacesKeyspace Configurations ============

#================ KeyspacesTable Configurations ===================
variable "dynamodb_tabledefinition_file" {
  description = "Table definition file name of the DynamoDB's tables. The table definition file must be in the TFCustomResourceConfigs folder. Example: dynamodb_table_definition.json"
  type        = string
  default     = null

  # validation {
  #   condition     = substr(var.dynamodb_tabledefinition_file, 0, 24) == "TFCustomResourceConfigs/"
  #   error_message = "File path must begin with TFCustomResourceConfigs/."
  # }
}

# variable "dynamodb_table_name" {
#   description = "The DynamoDB's table name. The first character must be a letter. Example: itembyprovider"
#   type        = string

#   validation {
#     condition     = can(regex("^[a-z][0-9a-z_]+$", var.dynamodb_table_name))
#     error_message = "Table name must start with a letter. Value only a-z and 0-9 are allowed."
#   }

#   validation {
#     condition     = length(var.dynamodb_table_name) > 3
#     error_message = "Table name length must be greater than 3."
#   }
# }

# variable "dynamodb_table_description" {
#   description = "The DynamoDB's table description."
#   type        = string
#   default     = null
# }

# variable "dynamodb_table_throughputmode" {
#   description = "The DynamoDB's table throughput mode. Valid values are PAY_PER_REQUEST or PROVISIONED."
#   type        = string
#   default     = "PAY_PER_REQUEST"

#   validation {
#     condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.dynamodb_table_throughputmode)
#     error_message = "Must either be PAY_PER_REQUEST or PROVISIONED."
#   }
# }

# variable "dynamodb_table_readcapacity" {
#   description = "The DynamoDB's table read capacity units."
#   type        = number
#   default     = 0
# }

# variable "dynamodb_table_writecapacity" {
#   description = "The DynamoDB's table write capacity units."
#   type        = number
#   default     = 0
# }

# variable "dynamodb_table_pointintimerecovery" {
#   description = "The DynamoDB's table point in time recovery status. Valid values are ENABLED or DISABLED."
#   type        = string
#   default     = "DISABLED"

#   validation {
#     condition     = contains(["ENABLED", "DISABLED"], var.dynamodb_table_pointintimerecovery)
#     error_message = "Must either be ENABLED or DISABLED."
#   }
# }

# variable "dynamodb_table_clientsidetimestamps" {
#   description = "The DynamoDB's table client side timestamps status. Valid values are ENABLED or DISABLED."
#   type        = string
#   default     = "DISABLED"

#   validation {
#     condition     = contains(["ENABLED", "DISABLED"], var.dynamodb_table_clientsidetimestamps)
#     error_message = "Must either be ENABLED or DISABLED."
#   }
# }

# variable "dynamodb_table_ttldefault" {
#   description = "The DynamoDB's table default ttl value. This is in seconds."
#   type        = number
#   default     = 0

#   validation {
#     condition     = var.dynamodb_table_ttldefault >= 0 && var.dynamodb_table_ttldefault <= 630720000
#     error_message = "Must between 0 and 630,720,000."
#   }
# }
#================ End of KeyspacesTable Configurations ============

#================ Route53Record Configurations ===================
variable "dynamodb_route53_hostedzoneid" {
  description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
  type        = string
}
#================ End of Route53Record Configurations ============