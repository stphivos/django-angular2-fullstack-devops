output "name" {
  value = "${aws_route53_record.frontend.name}"
}

output "alias" {
  value = "${aws_route53_record.frontend.alias.name}"
}
