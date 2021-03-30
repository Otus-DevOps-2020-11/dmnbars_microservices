provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "node" {
  count = var.instance_count
  name  = "k8s-${count.index}"

  labels = {
    tags = "k8s"
  }

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image
      type     = "network-ssd"
      size     = 40
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "yc-user:${file(var.public_key_path)}"
  }
}
