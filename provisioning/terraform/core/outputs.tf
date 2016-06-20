output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "subnet_id" {
  value = "${aws_subnet.default.id}"
}
