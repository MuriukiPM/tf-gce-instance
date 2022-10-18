output "instance_name" {
  description = "The name of the created instance"
  value       = google_compute_instance.gce-instance.name
}

output "instance_self_link" {
  description = "The self link of the created instance"
  value       = google_compute_instance.gce-instance.self_link
}

output "instance_int_ip" {
  value = google_compute_instance.gce-instance.network_interface.0.network_ip
}

output "instance_ext_ip" {
  description = "The static external address of the created instance"
  value       = google_compute_instance.gce-instance.network_interface[0].access_config[0].nat_ip
}

output "instance_sa" {
  description = "The service account email address assigned to the instance."
  value       = google_compute_instance.gce-instance.service_account[0].email
}

