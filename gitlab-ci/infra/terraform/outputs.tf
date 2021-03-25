output "external_ip_address" {
  value = yandex_compute_instance.gitlab-ci.network_interface[0].nat_ip_address
}
