output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.default.id}"
}

output "aws_route_internet_access_id" {
  value = "${aws_route.internet_access.id}"
}

output "default_subnet_id" {
  value = "${aws_subnet.default.id}"
}

output "secondary_subnet_id" {
  value = "${aws_subnet.secondary.id}"
}
