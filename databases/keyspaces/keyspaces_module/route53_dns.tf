#================ Route53Record Configurations ===================
resource "aws_route53_record" "keyspaces_route53_cname" {
  name            = "${local.keyspaces_route53_cname}-keyspaces.${data.aws_route53_zone.keyspaces_route53_hostedzoneid.name}"
  records         = ["cassandra.${local.region}.amazonaws.com"]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.keyspaces_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_keyspaces_keyspace.keyspaces_keyspace]
}
#================ End of Route53Record Configurations ============