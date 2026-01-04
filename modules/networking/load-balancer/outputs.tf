output "lb_ip" {
  # Retorna la IP del Forwarding Rule, ya sea Network o HTTP
  value = var.type == "NETWORK" ? google_compute_forwarding_rule.l4_forwarding[0].ip_address : google_compute_global_forwarding_rule.l7_forwarding[0].ip_address
}
