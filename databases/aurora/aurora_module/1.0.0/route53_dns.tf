#================ Route53Record Configurations ===================
resource "aws_route53_record" "aurora_route53_cname" {
  name            = "${local.aurora_route53_cname}.${data.aws_route53_zone.aurora_route53_hostedzoneid.name}"
  records         = [aws_rds_cluster.aurora_cluster_cluster.endpoint]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.aurora_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_rds_cluster.aurora_cluster_cluster, aws_rds_cluster_instance.aurora_cluster_instance]
}
#================ End of Route53Record Configurations ============