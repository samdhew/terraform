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
variable "ec2database_kms_multiregion" {
  description = "If true, KMS will be Multi Region rather than Regional."
  type        = bool
  default     = false

  validation {
    condition     = contains([true, false], var.ec2database_kms_multiregion)
    error_message = "Must either be true or false."
  }
}
#================ End of KMS Configurations ============

#================ SNS Configurations ===================
variable "ec2database_sns_subscriptionprotocol" {
  description = "The SNS topic subscription's Protocol. Valid values are email or email-json."
  type        = string
  default     = "email"

  validation {
    condition     = contains(["email", "email-json"], var.ec2database_sns_subscriptionprotocol)
    error_message = "Must either be email or email-json."
  }
}

variable "ec2database_sns_subscriptionendpoints" {
  description = "The SNS topic subscription's endpoints. This works for multiple email address values."
  type        = list(any)
  default     = []
}
#================ End of SNS Configurations ============

#================ SecurityGroup Configurations ===================
variable "ec2database_securitygroup_vpcid" {
  description = "VPC id where the EC2 backed database server will be deployed."
  type        = string

  validation {
    condition     = substr(var.ec2database_securitygroup_vpcid, 0, 4) == "vpc-"
    error_message = "VPC ID must begin with vpc-."
  }
}
#================ End of SecurityGroup Configurations ============

#================ EC2BackedDatabase Configurations ===================
variable "ec2database_cluster_name" {
  description = "The EC2 backed database server's name. The first character must be a letter. Example: tpi"
  type        = string
  default     = null
}

variable "ec2database_cluster_engine" {
  description = "The EC2 backed database engine type. Valid values are mysql or postgresql or oracle or sqlserver or mongodb or cassandra."
  type        = string

  validation {
    condition     = contains(["mysql", "postgresql", "oracle", "sqlserver", "mongodb", "cassandra"], var.ec2database_cluster_engine)
    error_message = "Must either be mysql or postgresql or oracle or sqlserver or mongodb or cassandra."
  }
}

variable "ec2database_subnetgroup_subnets" {
  description = "The EC2 backed database servers' subnets. This works for multiple subnet id values."
  type        = list(any)
  default     = null
}
variable "ec2database_cluster_instanceclass" {
  description = "The EC2 backed database server's instance class. Valid values are t3.medium or t4g.medium or r5.large or r5.xlarge or r5.2xlarge or r6g.large or r6g.xlarge or r6g.2xlarge."
  type        = string
  default     = "t3.medium"

  validation {
    condition     = contains(["t3.medium", "t4g.medium", "r5.large", "r5.xlarge", "r5.2xlarge", "r6g.large", "r6g.xlarge", "r6g.2xlarge"], var.ec2database_cluster_instanceclass)
    error_message = "Must either be t3.medium or t4g.medium or r5.large or r5.xlarge or r5.2xlarge or r6g.large or r6g.xlarge or r6g.2xlarge."
  }
}

variable "ec2database_instance_cpucores" {
  description = "The EC2 backed database server's CPU cores for vCPUs. Valid values are [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html] and rules in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-cpu-options-rules.html]."
  type        = number
  default     = 1
}

variable "ec2database_instance_threadspercore" {
  description = "The EC2 backed database server's CPU cores for vCPUs. Valid values are [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html] and rules in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-cpu-options-rules.html]."
  type        = number
  default     = 2
}

variable "ec2database_instance_count" {
  description = "The EC2 backed database server count. Servers will be spread across the AZs in"
  type        = number
  default     = 1
}

variable "ec2_userdata_file" {
  description = "Userdata file name for the EC2. This file must reside within TFCustomResourceConfigs folder."
  type        = string
  default     = "ec2_userdata.sh"

  validation {
    condition     = substr(var.ec2_userdata_file, -3, -1) == ".sh"
    error_message = "File must end with sh extension."
  }
}
#================ End of EC2BackedDatabase Configurations ============

#================ Route53Record Configurations ===================
# variable "ec2database_route53_hostedzoneid" {
#   description = "The Hosted zone ID. Example: Z0270985K4K59VI2QMIK"
#   type        = string
# }
#================ End of Route53Record Configurations ============