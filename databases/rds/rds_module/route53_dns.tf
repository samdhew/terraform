# #================ Route53Record Configurations ===================
resource "aws_route53_record" "rds_route53_cname" {
  name            = "${local.rds_route53_cname}.${data.aws_route53_zone.rds_route53_hostedzoneid.name}"
  records         = [aws_db_instance.rds_db_instance.address]
  ttl             = 120
  type            = "CNAME"
  zone_id         = var.rds_route53_hostedzoneid
  allow_overwrite = true
  depends_on      = [aws_db_instance.rds_db_instance]
}
# #================ End of Route53Record Configurations ============