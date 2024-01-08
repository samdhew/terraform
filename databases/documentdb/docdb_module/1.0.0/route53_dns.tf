#================ Route53Record Configurations ===================
resource "aws_route53_record" "docdb_route53_cname" {
  name            = "${local.docdb_route53_cname}.${data.aws_route53_zone.docdb_route53_hostedzoneid.name}"
  records         = [aws_docdb_cluster.docdb_cluster_cluster.endpoint]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.docdb_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_docdb_cluster.docdb_cluster_cluster, aws_docdb_cluster_instance.docdb_cluster_instance]
}
#================ End of Route53Record Configurations ============