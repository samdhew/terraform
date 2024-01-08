#================ KeyPair Configurations ===================
resource "aws_key_pair" "ec2database_privatekey" {
  key_name   = local.ec2database_sshkey_name
  public_key = data.aws_secretsmanager_secret_version.ec2database_sshkey_creds.secret_string
  tags       = merge(local.tags, { Name : local.ec2database_sshkey_name })
}

# resource "local_sensitive_file" "ec2database_privatekey" {
#   filename             = "TFCustomResourceConfigs/${local.ec2database_sshkey_name}.pem"
#   file_permission      = "600"
#   directory_permission = "700"
#   content              = tls_private_key.ec2database_privatekey_rsa4096.private_key_openssh
# }

resource "aws_instance" "ec2database_cluster_instance" {
  count         = var.ec2database_instance_count
  ami           = data.aws_ami.ec2database_ami_pcmubuntu.id
  instance_type = var.ec2database_cluster_instanceclass
  enclave_options {
    enabled = false
  }
  subnet_id = element(local.ec2database_subnet_ids, count.index)
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
    hostname_type                     = "ip-name"
  }
  vpc_security_group_ids = [aws_security_group.ec2database_securitygroup_database.id, aws_security_group.ec2database_securitygroup_ec2.id]
  cpu_options {
    core_count       = var.ec2database_instance_cpucores
    threads_per_core = var.ec2database_instance_threadspercore
  }
  get_password_data    = null
  hibernation          = false
  iam_instance_profile = aws_iam_instance_profile.ec2database_iaminstanceprofile_ec2.name
  key_name             = aws_key_pair.ec2database_privatekey.key_name
  ebs_optimized        = true
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    iops                  = 3000
    throughput            = 125
    encrypted             = true
    kms_key_id            = aws_kms_key.ec2database_kms_key.arn
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_type           = "gp3"
    volume_size           = 100
    iops                  = 3000
    throughput            = 125
    encrypted             = true
    kms_key_id            = aws_kms_key.ec2database_kms_key.arn
    delete_on_termination = true
  }
  monitoring = true
  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }
  maintenance_options {
    auto_recovery = "default"
  }
  instance_initiated_shutdown_behavior = "stop"
  user_data                            = base64encode(data.template_file.ec2database_ec2_userdata.rendered)
  user_data_replace_on_change          = false
  disable_api_stop                     = true
  disable_api_termination              = true

  volume_tags = merge(local.tags, { Name : "${local.ec2database_ec2_name}-${count.index + 1}" })
  tags        = merge(local.tags, { Name : "${local.ec2database_ec2_name}-${count.index + 1}" })
}
#================ KeyPair Configurations ===================