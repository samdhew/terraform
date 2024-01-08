locals {
  account_id = data.aws_caller_identity.current.account_id
  # region                               = data.aws_region.current.name
  app_name                           = lookup(var.mandatory_tags, "t_AppName", "")
  environment                        = lookup(var.mandatory_tags, "t_environment", "")
  unique_name                        = var.rds_instance_name == null ? lower("${local.app_name}-${local.environment}-${local.rds_instance_engine[var.rds_instance_engine]["commonname"]}") : lower("${var.rds_instance_name}-${local.environment}-${local.rds_instance_engine[var.rds_instance_engine]["commonname"]}")
  rdslambda_iamrole_name             = lower("${local.unique_name}-rdslambda-iamrole")
  rdsenhancedmonitoring_iamrole_name = lower("${local.unique_name}-rdsenhancedmonitoring-iamrole")
  rdslambda_iampolicy_name           = lower("${local.unique_name}-rdslambda-iampolicy")
  # rdsenhancedmonitoring_iampolicy_name = lower("${local.unique_name}-rdsenhancedmonitoring-iampolicy")
  custom_iampolicy_name = lower("${local.unique_name}-custom-iampolicy")
  # rds_s3bucket_name                    = lower("${local.unique_name}-rds-s3bucket")
  rds_kms_name                    = lower("${local.unique_name}-kms")
  rds_sns_name                    = lower("${local.unique_name}-sns")
  rds_secret_name                 = lower("${local.unique_name}-secret")
  rds_securitygroup_name          = lower("${local.unique_name}-securitygroup")
  rds_subnetgroup_name            = lower("${local.unique_name}-subnetgroup")
  rds_parametergroupinstance_name = lower("${local.unique_name}-parametergroupinstance")
  rds_optiongroupinstance_name    = lower("${local.unique_name}-optiongroupinstance")
  rds_instance_name               = lower("${local.unique_name}-instance")
  rds_route53_cname               = local.unique_name
  rds_instance_engine = {
    mariadb = {
      engine = "mariadb"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "10.3.39" = "10.3.39"
        "10.4.30" = "10.4.30"
        "10.5.21" = "10.5.21"
        "10.6.14" = "10.6.14"
        "10.11.4" = "10.11.4"
      }
      parameterfamily = {
        "10.3.39" = "mariadb10.3"
        "10.4.30" = "mariadb10.4"
        "10.5.21" = "mariadb10.5"
        "10.6.14" = "mariadb10.6"
        "10.11.4" = "mariadb10.11"
      }
      optionfamily = {
        "10.3.39" = "10.3"
        "10.4.30" = "10.4"
        "10.5.21" = "10.5"
        "10.6.14" = "10.6"
        "10.11.4" = "10.11"
      }
      parametergroupinstancefile = "mariadb_parametergroup_instance.json"
      optiongroupinstancefile    = "mariadb_optiongroup_instance.json"
      licensemodel               = "general-public-license"
      username                   = "mariadbAdmin"
      port                       = "3306"
      cwlogs                     = ["general", "audit", "error", "slowquery"]
      commonname                 = "mariadb"
    }

    mysql = {
      engine = "mysql"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "5.7.43" = "5.7.43"
        "8.0.34" = "8.0.34"
      }
      parameterfamily = {
        "5.7.43" = "mysql5.7"
        "8.0.34" = "mysql8.0"
      }
      optionfamily = {
        "5.7.43" = "5.7"
        "8.0.34" = "8.0"
      }
      parametergroupinstancefile = "mysql_parametergroup_instance.json"
      optiongroupinstancefile    = "mysql_optiongroup_instance.json"
      licensemodel               = "general-public-license"
      username                   = "mysqlAdmin"
      port                       = "3306"
      cwlogs                     = ["general", "audit", "error", "slowquery"]
      commonname                 = "mysql"
    }

    oracle-ee = {
      engine = "oracle-ee"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "19.0.0.0.ru-2019-07.rur-2019-07.r1" = "19.0.0.0.ru-2019-07.rur-2019-07.r1"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "19.0.0.0.ru-2020-10.rur-2020-10.r1"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19.0.0.0.ru-2021-10.rur-2021-10.r1"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19.0.0.0.ru-2022-10.rur-2022-10.r1"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19.0.0.0.ru-2023-07.rur-2023-07.r1"
      }
      parameterfamily = {
        "19.0.0.0.ru-2019-07.rur-2019-07.r1" = "oracle-ee-19"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "oracle-ee-19"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "oracle-ee-19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-ee-19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-ee-19"
      }
      optionfamily = {
        "19.0.0.0.ru-2019-07.rur-2019-07.r1" = "19"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "19"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19"
      }
      parametergroupinstancefile = "oracle_parametergroup_instance.json"
      optiongroupinstancefile    = "oracle_optiongroup_instance.json"
      licensemodel               = var.rds_instance_enginelicensemodel
      username                   = "oracleAdmin"
      port                       = "1521"
      cwlogs                     = ["alert", "audit", "listener", "trace", "oemagent"]
      commonname                 = "oracle"
    }

    oracle-ee-cdb = {
      engine = "oracle-ee-cdb"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19.0.0.0.ru-2021-10.rur-2021-10.r1"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19.0.0.0.ru-2022-10.rur-2022-10.r1"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19.0.0.0.ru-2023-07.rur-2023-07.r1"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "21.0.0.0.ru-2022-10.rur-2022-10.r1"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "21.0.0.0.ru-2023-07.rur-2023-07.r1"
      }
      parameterfamily = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "oracle-ee-cdb-19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-ee-cdb-19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-ee-cdb-19"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-ee-cdb-21"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-ee-cdb-21"
      }
      optionfamily = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "21"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "21"
      }
      parametergroupinstancefile = "oracle_parametergroup_instance.json"
      optiongroupinstancefile    = "oracle_optiongroup_instance.json"
      licensemodel               = var.rds_instance_enginelicensemodel
      username                   = "oracleAdmin"
      port                       = "1521"
      cwlogs                     = ["alert", "audit", "listener", "trace", "oemagent"]
      commonname                 = "oracle"
    }

    oracle-se2 = {
      engine = "oracle-se2"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "19.0.0.0.ru-2019-10.rur-2019-10.r1" = "19.0.0.0.ru-2019-10.rur-2019-10.r1"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "19.0.0.0.ru-2020-10.rur-2020-10.r1"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19.0.0.0.ru-2021-10.rur-2021-10.r1"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19.0.0.0.ru-2022-10.rur-2022-10.r1"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19.0.0.0.ru-2023-07.rur-2023-07.r1"
      }
      parameterfamily = {
        "19.0.0.0.ru-2019-10.rur-2019-10.r1" = "oracle-se2-19"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "oracle-se2-19"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "oracle-se2-19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-se2-19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-se2-19"
      }
      optionfamily = {
        "19.0.0.0.ru-2019-10.rur-2019-10.r1" = "19"
        "19.0.0.0.ru-2020-10.rur-2020-10.r1" = "19"
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19"
      }
      parametergroupinstancefile = "oracle_parametergroup_instance.json"
      optiongroupinstancefile    = "oracle_optiongroup_instance.json"
      licensemodel               = var.rds_instance_enginelicensemodel
      username                   = "oracleAdmin"
      port                       = "1521"
      cwlogs                     = ["alert", "audit", "listener", "trace", "oemagent"]
      commonname                 = "oracle"
    }

    oracle-se2-cdb = {
      engine = "oracle-se2-cdb"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19.0.0.0.ru-2021-10.rur-2021-10.r1"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19.0.0.0.ru-2022-10.rur-2022-10.r1"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19.0.0.0.ru-2023-07.rur-2023-07.r1"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "21.0.0.0.ru-2022-10.rur-2022-10.r1"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "21.0.0.0.ru-2023-07.rur-2023-07.r1"
      }
      parameterfamily = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "oracle-se2-cdb-19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-se2-cdb-19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-se2-cdb-19"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "oracle-se2-cdb-21"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "oracle-se2-cdb-21"
      }
      optionfamily = {
        "19.0.0.0.ru-2021-10.rur-2021-10.r1" = "19"
        "19.0.0.0.ru-2022-10.rur-2022-10.r1" = "19"
        "19.0.0.0.ru-2023-07.rur-2023-07.r1" = "19"
        "21.0.0.0.ru-2022-10.rur-2022-10.r1" = "21"
        "21.0.0.0.ru-2023-07.rur-2023-07.r1" = "21"
      }
      parametergroupinstancefile = "oracle_parametergroup_instance.json"
      optiongroupinstancefile    = "oracle_optiongroup_instance.json"
      licensemodel               = var.rds_instance_enginelicensemodel
      username                   = "oracleAdmin"
      port                       = "1521"
      cwlogs                     = ["alert", "audit", "listener", "trace", "oemagent"]
      commonname                 = "oracle"
    }
    postgresql = {
      engine = "postgres"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "11.20" = "11.20"
        "12.15" = "12.15"
        "13.11" = "13.11"
        "14.8"  = "14.8"
        "15.3"  = "15.3"
      }
      parameterfamily = {
        "11.20" = "postgres11"
        "12.15" = "postgres12"
        "13.11" = "postgres13"
        "14.8"  = "postgres14"
        "15.3"  = "postgres15"
      }
      parametergroupinstancefile = "pgsql_parametergroup_instance.json"
      optiongroupinstancefile    = "pgsql_optiongroup_instance.json"
      licensemodel               = "postgresql-license"
      username                   = "pgsqlAdmin"
      port                       = "5432"
      cwlogs                     = ["postgresql", "upgrade"]
      commonname                 = "pgsql"
    }

    sqlserver-ee = {
      engine = "sqlserver-ee"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "12.00.6444.4.v1"  = "12.00.6444.4.v1"
        "13.00.6430.49.v1" = "13.00.6430.49.v1"
        "14.00.3460.9.v1"  = "14.00.3460.9.v1"
        "15.00.4316.3.v1"  = "15.00.4316.3.v1"
      }
      parameterfamily = {
        "12.00.6444.4.v1"  = "sqlserver-ee-12.0"
        "13.00.6430.49.v1" = "sqlserver-ee-13.0"
        "14.00.3460.9.v1"  = "sqlserver-ee-14.0"
        "15.00.4316.3.v1"  = "sqlserver-ee-15.0"
      }
      optionfamily = {
        "12.00.6444.4.v1"  = "12.00"
        "13.00.6430.49.v1" = "13.00"
        "14.00.3460.9.v1"  = "14.00"
        "15.00.4316.3.v1"  = "15.00"
      }
      parametergroupinstancefile = "mssql_parametergroup_instance.json"
      optiongroupinstancefile    = "mssql_optiongroup_instance.json"
      licensemodel               = "license-included"
      username                   = "sqlserverAdmin"
      port                       = "1433"
      cwlogs                     = ["error", "agent"]
      commonname                 = "mssql"
    }

    sqlserver-se = {
      engine = "sqlserver-se"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "12.00.6444.4.v1"  = "12.00.6444.4.v1"
        "13.00.6430.49.v1" = "13.00.6430.49.v1"
        "14.00.3460.9.v1"  = "14.00.3460.9.v1"
        "15.00.4316.3.v1"  = "15.00.4316.3.v1"
      }
      parameterfamily = {
        "12.00.6444.4.v1"  = "sqlserver-se-12.0"
        "13.00.6430.49.v1" = "sqlserver-se-13.0"
        "14.00.3460.9.v1"  = "sqlserver-se-14.0"
        "15.00.4316.3.v1"  = "sqlserver-se-15.0"
      }
      optionfamily = {
        "12.00.6444.4.v1"  = "12.00"
        "13.00.6430.49.v1" = "13.00"
        "14.00.3460.9.v1"  = "14.00"
        "15.00.4316.3.v1"  = "15.00"
      }
      parametergroupinstancefile = "mssql_parametergroup_instance.json"
      optiongroupinstancefile    = "mssql_optiongroup_instance.json"
      licensemodel               = "license-included"
      username                   = "sqlserverAdmin"
      port                       = "1433"
      cwlogs                     = ["error", "agent"]
      commonname                 = "mssql"
    }

    sqlserver-ex = {
      engine = "sqlserver-ex"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "12.00.6444.4.v1"  = "12.00.6444.4.v1"
        "13.00.6430.49.v1" = "13.00.6430.49.v1"
        "14.00.3460.9.v1"  = "14.00.3460.9.v1"
        "15.00.4316.3.v1"  = "15.00.4316.3.v1"
      }
      parameterfamily = {
        "12.00.6444.4.v1"  = "sqlserver-ex-12.0"
        "13.00.6430.49.v1" = "sqlserver-ex-13.0"
        "14.00.3460.9.v1"  = "sqlserver-ex-14.0"
        "15.00.4316.3.v1"  = "sqlserver-ex-15.0"
      }
      optionfamily = {
        "12.00.6444.4.v1"  = "12.00"
        "13.00.6430.49.v1" = "13.00"
        "14.00.3460.9.v1"  = "14.00"
        "15.00.4316.3.v1"  = "15.00"
      }
      parametergroupinstancefile = "mssql_parametergroup_instance.json"
      optiongroupinstancefile    = "mssql_optiongroup_instance.json"
      licensemodel               = "license-included"
      username                   = "sqlserverAdmin"
      port                       = "1433"
      cwlogs                     = ["error", "agent"]
      commonname                 = "mssql"
    }

    sqlserver-web = {
      engine = "sqlserver-web"
      enginemode = {
        provisioned = "provisioned"
        serverless  = "serverless"
      }
      engineversion = {
        "12.00.6444.4.v1"  = "12.00.6444.4.v1"
        "13.00.6430.49.v1" = "13.00.6430.49.v1"
        "14.00.3460.9.v1"  = "14.00.3460.9.v1"
        "15.00.4316.3.v1"  = "15.00.4316.3.v1"
      }
      parameterfamily = {
        "12.00.6444.4.v1"  = "sqlserver-web-12.0"
        "13.00.6430.49.v1" = "sqlserver-web-13.0"
        "14.00.3460.9.v1"  = "sqlserver-web-14.0"
        "15.00.4316.3.v1"  = "sqlserver-web-15.0"
      }
      optionfamily = {
        "12.00.6444.4.v1"  = "12.00"
        "13.00.6430.49.v1" = "13.00"
        "14.00.3460.9.v1"  = "14.00"
        "15.00.4316.3.v1"  = "15.00"
      }
      parametergroupinstancefile = "mssql_parametergroup_instance.json"
      optiongroupinstancefile    = "mssql_optiongroup_instance.json"
      licensemodel               = "license-included"
      username                   = "sqlserverAdmin"
      port                       = "1433"
      cwlogs                     = ["error", "agent"]
      commonname                 = "mssql"
    }
  }
  rds_parametergroupinstance_file = var.rds_parametergroupinstance_file == null ? local.rds_instance_engine[var.rds_instance_engine]["parametergroupinstancefile"] : var.rds_parametergroupinstance_file
  rds_parametergroupinstance_data = jsondecode(file("TFCustomResourceConfigs/${local.rds_parametergroupinstance_file}"))
  rds_optiongroupinstance_file    = var.rds_optiongroupinstance_file == null ? local.rds_instance_engine[var.rds_instance_engine]["optiongroupinstancefile"] : var.rds_optiongroupinstance_file
  rds_optiongroupinstance_data    = jsondecode(file("TFCustomResourceConfigs/${local.rds_optiongroupinstance_file}"))
  tags                            = merge(var.mandatory_tags, var.default_tags)
  # temp_tags = concat(
  #   [
  #     for key, value in local.tags :
  #     {
  #       key                 = key
  #       value               = value
  #       propagate_at_launch = true
  #     }
  #   ]
  # )
}