#================ Route53Record Configurations ===================
resource "aws_route53_record" "dynamodb_route53_cname" {
  name            = "${local.dynamodb_route53_cname}-dynamodb.${data.aws_route53_zone.dynamodb_route53_hostedzoneid.name}"
  records         = ["cassandra.${local.region}.amazonaws.com"]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.dynamodb_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_dynamodb_keyspace.dynamodb_keyspace]
}
#================ End of Route53Record Configurations ============