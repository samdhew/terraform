#================ OptionGroup Configurations ===================
resource "aws_db_option_group" "rds_optiongroup_instance" {
  # count = local.rds_instance_engine[var.rds_instance_engine]["commonname"] != "pgsql" ? 1 : 0
  name                     = local.rds_optiongroupinstance_name
  option_group_description = local.rds_optiongroupinstance_name
  engine_name              = var.rds_instance_engine
  major_engine_version     = local.rds_instance_engine[var.rds_instance_engine]["optionfamily"][var.rds_instance_engineversion]
  dynamic "option" {
    for_each = local.rds_optiongroupinstance_data.options
    content {
      option_name = option.value.option_name
      option_settings {
        name  = option.value.name
        value = option.value.value
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.tags, { Name : local.rds_optiongroupinstance_name })
}
#================ End of OptionGroup Configurations ============