provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_kubernetes_cluster" "cluster" {
  name       = "dev"
  network_id = var.network_id

  master {
    version = "1.19"
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
    public_ip = true
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel = "RAPID"
}

resource "yandex_kubernetes_node_group" "node" {
  cluster_id = yandex_kubernetes_cluster.cluster.id
  version    = "1.19"

  name = "node"

  instance_template {
    resources {
      cores  = var.cores
      memory = var.memory
    }

    boot_disk {
      type = "network-ssd"
      size = var.disk
    }

    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }

    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.nodes_count
    }
  }
}
