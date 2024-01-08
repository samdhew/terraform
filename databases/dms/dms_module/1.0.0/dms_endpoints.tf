#================ DMS Endpoint Configurations ===================
resource "aws_dms_endpoint" "dms_replication_endpoint" {
  for_each                        = { for endpoint in local.dms_replicationendpoint_data.endpoints : endpoint.endpoint_id => endpoint }
  endpoint_id                     = each.value.endpoint_id
  endpoint_type                   = each.value.endpoint_type
  engine_name                     = each.value.engine_name
  kms_key_arn                     = each.value.engine_name == "s3" ? null : aws_kms_key.dms_kms_key.arn
  secrets_manager_arn             = each.value.secrets_manager_arn
  secrets_manager_access_role_arn = each.value.secrets_manager_arn == null ? null : each.value.secrets_manager_access_role_arn
  server_name                     = each.value.secrets_manager_arn != null ? null : each.value.server_name
  port                            = each.value.secrets_manager_arn != null ? null : each.value.port
  database_name                   = each.value.database_name
  username                        = each.value.secrets_manager_arn != null ? null : each.value.username
  password                        = each.value.secrets_manager_arn != null ? null : each.value.password
  extra_connection_attributes     = each.value.extra_connection_attributes
  ssl_mode                        = each.value.ssl_mode
  certificate_arn                 = each.value.ssl_mode == "none" ? null : each.value.certificate_arn
  service_access_role             = each.value.engine_name != "dynamodb" ? null : each.value.service_access_role
  # dynamic "elasticsearch_settings" {
  #   for_each = each.value.engine_name == "elasticsearch" ? toset([1]) : toset([])
  #   content {
  #     endpoint_uri               = var.dms_replicationendpointelasticsearch_endpointuri
  #     error_retry_duration       = var.dms_replicationendpointelasticsearch_errorretryduration
  #     full_load_error_percentage = var.dms_replicationendpointelasticsearch_fullloaderrorpercentage
  #     service_access_role_arn    = var.dms_replicationendpointelasticsearch_serviceaccessrolearn
  #   }
  # }
  # dynamic "kafka_settings" {
  #   for_each = each.value.engine_name == "kafka" ? toset([1]) : toset([])
  #   content {
  #     topic                          = var.dms_replicationendpointkafka_topic
  #     security_protocol              = var.dms_replicationendpointkafka_securityprotocol
  #     sasl_username                  = var.dms_replicationendpointkafka_saslusername
  #     sasl_password                  = var.dms_replicationendpointkafka_saslpassword
  #     ssl_ca_certificate_arn         = var.dms_replicationendpointkafka_sslcacertificatearn
  #     ssl_client_certificate_arn     = var.dms_replicationendpointkafka_sslclientcertificatearn
  #     ssl_client_key_arn             = var.dms_replicationendpointkafka_sslclientkeyarn
  #     ssl_client_key_password        = var.dms_replicationendpointkafka_sslclientkeypassword
  #     message_format                 = var.dms_replicationendpointkafka_messageformat
  #     message_max_bytes              = var.dms_replicationendpointkafka_messagemaxbytes
  #     no_hex_prefix                  = var.dms_replicationendpointkafka_nohexprefix
  #     broker                         = var.dms_replicationendpointkafka_broker
  #     partition_include_schema_table = var.dms_replicationendpointkafka_partitionincludeschematable
  #     include_control_details        = var.dms_replicationendpointkafka_includecontroldetails
  #     include_null_and_empty         = var.dms_replicationendpointkafka_includenullandempty
  #     include_partition_value        = var.dms_replicationendpointkafka_includepartitionvalue
  #     include_table_alter_operations = var.dms_replicationendpointkafka_includetablealteroperations
  #     include_transaction_details    = var.dms_replicationendpointkafka_includetransactiondetails
  #   }
  # }
  # dynamic "kinesis_settings" {
  #   for_each = each.value.engine_name == "kinesis" ? toset([1]) : toset([])
  #   content {
  #     stream_arn                     = var.dms_replicationendpointkinesis_streamarn
  #     service_access_role_arn        = var.dms_replicationendpointkinesis_serviceaccessrolearn
  #     message_format                 = var.dms_replicationendpointkinesis_messageformat
  #     partition_include_schema_table = var.dms_replicationendpointkinesis_partitionincludeschematable
  #     include_control_details        = var.dms_replicationendpointkinesis_includecontroldetails
  #     include_null_and_empty         = var.dms_replicationendpointkinesis_includenullandempty
  #     include_partition_value        = var.dms_replicationendpointkinesis_includepartitionvalue
  #     include_table_alter_operations = var.dms_replicationendpointkinesis_includetablealteroperations
  #     include_transaction_details    = var.dms_replicationendpointkinesis_includetransactiondetails
  #   }
  # }
  # dynamic "mongodb_settings" {
  #   for_each = each.value.engine_name == "mongodb" ? toset([1]) : toset([])
  #   content {
  #     auth_source         = var.dms_replicationendpointmongodb_authsource
  #     auth_type           = var.dms_replicationendpointmongodb_authtype
  #     auth_mechanism      = var.dms_replicationendpointmongodb_authmechanism
  #     nesting_level       = var.dms_replicationendpointmongodb_nestinglevel
  #     extract_doc_id      = var.dms_replicationendpointmongodb_extractdocid
  #     docs_to_investigate = var.dms_replicationendpointmongodb_docstoinvestigate
  #   }
  # }
  # dynamic "redis_settings" {
  #   for_each = each.value.engine_name == "redis" ? toset([1]) : toset([])
  #   content {
  #     server_name            = var.dms_replicationendpointredis_servername
  #     port                   = var.dms_replicationendpointredis_port
  #     auth_type              = var.dms_replicationendpointredis_authtype
  #     auth_user_name         = var.dms_replicationendpointredis_authusername
  #     auth_password          = var.dms_replicationendpointredis_authpassword
  #     ssl_security_protocol  = var.dms_replicationendpointredis_sslsecurityprotocol
  #     ssl_ca_certificate_arn = var.dms_replicationendpointredis_sslcacertificatearn
  #   }
  # }
  # dynamic "redshift_settings" {
  #   for_each = each.value.engine_name == "redshift" ? toset([1]) : toset([])
  #   content {
  #     bucket_name                       = var.dms_replicationendpointredshift_bucketname
  #     bucket_folder                     = var.dms_replicationendpointredshift_bucketfolder
  #     encryption_mode                   = var.dms_replicationendpointredshift_encryptionmode
  #     server_side_encryption_kms_key_id = var.dms_replicationendpointredshift_serversideencryptionkmskeyid
  #     service_access_role_arn           = var.dms_replicationendpointredshift_serviceaccessrolearn
  #   }
  # }
  # dynamic "s3_settings" {
  #   for_each = each.value.engine_name == "s3" ? toset([1]) : toset([])
  #   content {
  #     bucket_name                                 = var.dms_replicationendpoints3_bucketname
  #     bucket_folder                               = var.dms_replicationendpoints3_bucketfolder
  #     encryption_mode                             = var.dms_replicationendpoints3_encryptionmode
  #     server_side_encryption_kms_key_id           = var.dms_replicationendpoints3_serversideencryptionkmskeyid
  #     canned_acl_for_objects                      = var.dms_replicationendpoints3_cannedaclforobjects
  #     compression_type                            = var.dms_replicationendpoints3_compressiontype
  #     encoding_type                               = var.dms_replicationendpoints3_encodingtype
  #     rfc_4180                                    = var.dms_replicationendpoints3_rfc4180
  #     row_group_length                            = var.dms_replicationendpoints3_rowgrouplength
  #     timestamp_column_name                       = var.dms_replicationendpoints3_timestampcolumnname
  #     use_task_start_time_for_full_load_timestamp = var.dms_replicationendpoints3_usetaskstarttimeforfullloadtimestamp
  #     cdc_path                                    = var.dms_replicationendpoints3_cdcpath
  #     cdc_inserts_and_updates                     = var.dms_replicationendpoints3_cdcinsertsandupdates
  #     cdc_inserts_only                            = var.dms_replicationendpoints3_cdcinsertsonly
  #     cdc_max_batch_interval                      = var.dms_replicationendpoints3_cdcmaxbatchinterval
  #     cdc_min_file_size                           = var.dms_replicationendpoints3_cdcminfilesize
  #     preserve_transactions                       = var.dms_replicationendpoints3_preservetransactions
  #     csv_delimiter                               = var.dms_replicationendpoints3_csvdelimiter
  #     csv_row_delimiter                           = var.dms_replicationendpoints3_csvrowdelimiter
  #     csv_no_sup_value                            = var.dms_replicationendpoints3_csvnosupvalue
  #     csv_null_value                              = var.dms_replicationendpoints3_csvnullvalue
  #     max_file_size                               = var.dms_replicationendpoints3_maxfilesize
  #     use_csv_no_sup_value                        = var.dms_replicationendpoints3_usecsvnosupvalue
  #     add_column_name                             = var.dms_replicationendpoints3_addcolumnname
  #     data_format                                 = var.dms_replicationendpoints3_dataformat
  #     data_page_size                              = var.dms_replicationendpoints3_datapagesize
  #     date_partition_enabled                      = var.dms_replicationendpoints3_datepartitionenabled
  #     date_partition_sequence                     = var.dms_replicationendpoints3_datepartitionsequence
  #     date_partition_delimiter                    = var.dms_replicationendpoints3_datepartitiondelimiter
  #     dict_page_size_limit                        = var.dms_replicationendpoints3_dictpagesizelimit
  #     enable_statistics                           = var.dms_replicationendpoints3_enablestatistics
  #     parquet_timestamp_in_millisecond            = var.dms_replicationendpoints3_parquettimestampinmillisecond
  #     parquet_version                             = var.dms_replicationendpoints3_parquetversion
  #     external_table_definition                   = var.dms_replicationendpoints3_externaltabledefinition
  #     ignore_header_rows                          = var.dms_replicationendpoints3_ignoreheaderrows
  #     include_op_for_full_load                    = var.dms_replicationendpoints3_includeopforfullload
  #     service_access_role_arn                     = var.dms_replicationendpoints3_serviceaccessrolearn
  #   }
  # }
  depends_on = [aws_dms_replication_instance.dms_replication_instance]
  tags       = merge(local.tags, { Name : local.dms_replicationendpoint_name })
}
#================ End of DMS Endpoint Configurations ============