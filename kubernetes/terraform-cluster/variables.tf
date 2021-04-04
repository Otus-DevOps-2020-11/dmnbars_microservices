variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key .json"
}
variable cores {
  description = "App VM cores count"
  default     = 4
}
variable memory {
  description = "App VM memory count"
  default     = 8
}
variable disk {
  description = "Amount of disk"
  default     = 64
}
variable nodes_count {
  description = "Nodes count"
  default     = 2
}
variable network_id {
  description = "Network id"
}
variable service_account_id {
  description = "Service account ID"
}
