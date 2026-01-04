output "self_link" {
  description = "El URI del template creado"
  value       = google_compute_instance_template.this.self_link
}

output "name" {
  value = google_compute_instance_template.this.name
}