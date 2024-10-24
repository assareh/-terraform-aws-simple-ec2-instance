output "public_dns" {
  value = aws_lb.this.dns_name
}

check "http_health_check" {
  data "http" "public_endpoint" {
    url = "http://${aws_lb.this.dns_name}"
  }

  assert {
    condition     = data.http.public_endpoint.status_code == 200
    error_message = "${data.http.public_endpoint.url} returned an unhealthy status code"
  }
}