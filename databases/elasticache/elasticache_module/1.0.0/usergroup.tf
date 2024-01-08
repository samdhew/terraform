#================ User Configurations ===================
resource "aws_elasticache_user" "elasticache_user_redisadmin" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_id       = local.elasticache_useradmin_name
  user_name     = local.elasticache_useradmin_name
  engine        = upper(local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"])
  access_string = "on ~* +@all"
  authentication_mode {
    type      = "password"
    passwords = [jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["auth"], jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["password"]]
  }
  tags = merge(local.tags, { Name : local.elasticache_useradmin_name })
}

resource "aws_elasticache_user" "elasticache_user_writeappuser" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_id       = local.elasticache_userwriteapp_name
  user_name     = local.elasticache_userwriteapp_name
  engine        = upper(local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"])
  access_string = "on ~* -@all +@write"
  authentication_mode {
    type      = "password"
    passwords = [jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["auth"], jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["writer_password"]]
  }
  tags = merge(local.tags, { Name : local.elasticache_userwriteapp_name })
}

resource "aws_elasticache_user" "elasticache_user_readappuser" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_id       = local.elasticache_userreadapp_name
  user_name     = local.elasticache_userreadapp_name
  engine        = upper(local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"])
  access_string = "on ~* -@all +@read"
  authentication_mode {
    type      = "password"
    passwords = [jsondecode(data.aws_secretsmanager_secret_version.elasticache_admin_creds.secret_string)["auth"], jsondecode(data.aws_secretsmanager_secret_version.elasticache_app_creds.secret_string)["reader_password"]]
  }
  tags = merge(local.tags, { Name : local.elasticache_userreadapp_name })
}
#================ End of User Configurations ============

#================ UserGroup Configurations ===================
resource "aws_elasticache_user_group" "elasticache_usergroup_admin" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_group_id = local.elasticache_usergroupadmin_name
  engine        = upper(local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"])
  user_ids      = ["new-default-user"]
  tags          = merge(local.tags, { Name : local.elasticache_usergroupadmin_name })
}

resource "aws_elasticache_user_group" "elasticache_usergroup_app" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_group_id = local.elasticache_usergroupapp_name
  engine        = upper(local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"])
  user_ids      = ["new-default-user"]
  tags          = merge(local.tags, { Name : local.elasticache_usergroupapp_name })
}
#================ End of UserGroup Configurations ============

#================ UserGroupAssociation Configurations ===================
resource "aws_elasticache_user_group_association" "elasticache_usergroupassociation_admin" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_group_id = aws_elasticache_user_group.elasticache_usergroup_admin[0].user_group_id
  user_id       = aws_elasticache_user.elasticache_user_redisadmin[0].user_id
}

resource "aws_elasticache_user_group_association" "elasticache_usergroupassociation_writeappuser" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_group_id = aws_elasticache_user_group.elasticache_usergroup_app[0].user_group_id
  user_id       = aws_elasticache_user.elasticache_user_writeappuser[0].user_id
}

resource "aws_elasticache_user_group_association" "elasticache_usergroupassociation_readappuser" {
  count         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "redis" ? 1 : 0
  user_group_id = aws_elasticache_user_group.elasticache_usergroup_app[0].user_group_id
  user_id       = aws_elasticache_user.elasticache_user_readappuser[0].user_id
}
#================ End of UserGroupAssociation Configurations ============