output "network_lb_ip" {
  description = "IP del Network Load Balancer (Task 2)"
  value       = google_compute_address.network_lb_ip.address
}

output "http_lb_ip" {
  description = "IP del HTTP Load Balancer (Task 3)"
  value       = google_compute_global_address.http_lb_ip.address
}
