#================ Route53Record Configurations ===================
# resource "aws_route53_record" "dms_route53_a" {
#   name            = "${local.dms_route53_cname}.${data.aws_route53_zone.dms_route53_hostedzoneid.name}"
#   records         = [aws_dms_replication_instance.dms_replication_instance.replication_instance_private_ips]
#   ttl             = 120
#   type            = "A"
#   zone_id         = var.dms_route53_hostedzoneid
#   allow_overwrite = true
#   depends_on      = [aws_dms_replication_instance.dms_replication_instance]
# }
#================ End of Route53Record Configurations ============