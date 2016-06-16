# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_route53_record" "frontend" {
  zone_id = "${var.aws_zone_id}"
  name = "${lookup(var.aws_env_domains, var.app_env)}"
  type = "A"

  alias {
    name = "s3-website.${var.aws_region}.amazonaws.com"
    zone_id = "${lookup(var.aws_s3_zones, var.aws_region)}"
    evaluate_target_health = true
  }
}
