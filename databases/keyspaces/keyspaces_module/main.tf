#================ KeyspacesKeyspace Configurations ===================
resource "aws_keyspaces_keyspace" "keyspaces_keyspace" {
  name = local.keyspaces_keyspace_name
  tags = merge(local.tags, { Name : local.keyspaces_keyspace_name })
}
#================ End of KeyspacesKeyspace Configurations ============

#================ KeyspacesTable Configurations ===================
resource "aws_keyspaces_table" "keyspaces_table" {
  for_each      = { for table in local.keyspaces_tabledefinition_data.tables : table.table_name => table }
  keyspace_name = aws_keyspaces_keyspace.keyspaces_keyspace.name
  table_name    = each.value.table_name
  comment {
    message = each.value.table_description == null ? each.value.table_name : each.value.table_description
  }
  encryption_specification {
    kms_key_identifier = aws_kms_key.keyspaces_kms_key.arn
    type               = "CUSTOMER_MANAGED_KMS_KEY"
  }
  capacity_specification {
    read_capacity_units  = each.value.table_throughputmode == "PROVISIONED" ? each.value.table_readcapacity > 0 ? each.value.table_readcapacity : 0 : null
    throughput_mode      = each.value.table_throughputmode #"PAY_PER_REQUEST" #"PROVISIONED"
    write_capacity_units = each.value.table_throughputmode == "PROVISIONED" ? each.value.table_writecapacity > 0 ? each.value.table_writecapacity : 0 : null
  }
  point_in_time_recovery {
    status = local.environment == "PROD" ? "ENABLED" : each.value.table_pointintimerecovery
  }
  client_side_timestamps {
    status = each.value.table_clientsidetimestamps
  }
  default_time_to_live = each.value.table_ttldefault == "0" ? null : each.value.table_ttldefault
  schema_definition {
    dynamic "partition_key" {
      for_each = each.value.table_schema.partition_keys
      content {
        name = partition_key.value.name
      }
    }
    dynamic "clustering_key" {
      for_each = each.value.table_schema.clustering_keys
      content {
        name     = clustering_key.value.name
        order_by = clustering_key.value.order_by
      }
    }
    dynamic "column" {
      for_each = each.value.table_schema.columns
      content {
        name = column.value.name
        type = column.value.type
      }
    }
  }
  depends_on = [aws_keyspaces_keyspace.keyspaces_keyspace]
  tags       = merge(local.tags, { keyspace : aws_keyspaces_keyspace.keyspaces_keyspace.name }, { Name : each.value.table_name })
}

# resource "aws_keyspaces_table" "keyspaces_table" {
#   keyspace_name = aws_keyspaces_keyspace.keyspaces_keyspace.name
#   table_name    = var.keyspaces_table_name
#   comment {
#     message = var.keyspaces_table_description == null ? var.keyspaces_table_name : var.keyspaces_table_description
#   }
#   encryption_specification {
#     kms_key_identifier = aws_kms_key.keyspaces_kms_key.arn
#     type               = "CUSTOMER_MANAGED_KMS_KEY"
#   }
#   capacity_specification {
#     read_capacity_units  = var.keyspaces_table_throughputmode == "PROVISIONED" ? var.keyspaces_table_readcapacity > 0 ? var.keyspaces_table_readcapacity : 0 : null
#     throughput_mode      = var.keyspaces_table_throughputmode #"PAY_PER_REQUEST" #"PROVISIONED"
#     write_capacity_units = var.keyspaces_table_throughputmode == "PROVISIONED" ? var.keyspaces_table_writecapacity > 0 ? var.keyspaces_table_writecapacity : 0 : null
#   }
#   point_in_time_recovery {
#     status = local.environment == "PROD" ? "ENABLED" : var.keyspaces_table_pointintimerecovery
#   }
#   client_side_timestamps {
#     status = var.keyspaces_table_clientsidetimestamps
#   }
#   default_time_to_live = var.keyspaces_table_ttldefault == 0 ? null : var.keyspaces_table_ttldefault
#   schema_definition {
#     partition_key {
#       name = "itemid"
#     }
#     clustering_key {
#       name     = "courseid"
#       order_by = "ASC"
#     }
#     clustering_key {
#       name     = "userid"
#       order_by = "ASC"
#     }
#     column {
#       name = "courseid"
#       type = "text"
#     }
#     column {
#       name = "itemid"
#       type = "text"
#     }
#     column {
#       name = "lastmodified"
#       type = "timestamp"
#     }
#     column {
#       name = "userid"
#       type = "text"
#     }
#   }
#   depends_on = [aws_keyspaces_keyspace.keyspaces_keyspace]
#   tags       = merge(local.tags, { keyspace : aws_keyspaces_keyspace.keyspaces_keyspace.name }, { Name : var.keyspaces_table_name })
# }
#================ End of KeyspacesTable Configurations ============