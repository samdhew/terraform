#================ Route53Record Configurations ===================
resource "aws_route53_record" "elasticache_route53_cname" {
  name            = "${local.elasticache_route53_cname}.${data.aws_route53_zone.elasticache_route53_hostedzoneid.name}"
  records         = local.elasticache_cluster_engine[var.elasticache_cluster_engine]["engine"] == "memcached" ? [aws_elasticache_cluster.elasticache_cluster_cluster.cluster_address] : [trimsuffix(aws_elasticache_replication_group.elasticache_replicationgroup_cluster[0].primary_endpoint_address, ":6379")]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.elasticache_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_elasticache_cluster.elasticache_cluster_cluster]
}
#================ End of Route53Record Configurations ============