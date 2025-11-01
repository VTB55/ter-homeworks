variable "yandex_cloud_id" {
  type    = string
  default = "b1g2236iog5d7i4a58vo"
}

variable "yandex_folder_id" {
  type    = string
  default = "b1gpc5he9k0da554outu"
}

variable "yandex_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "service_account_key_file" {
  type    = string
  default = "key.json"
}

variable "vms_ssh_public_root_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjzp2nZbWrRBGqf6jRl2dAuiJ8rANN9VOghO6Z7s/3c netology@netology"
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "default_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "vm_web_family_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

# Новые map переменные вместо отдельных переменных
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "vm_metadata" {
  type = map(any)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjzp2nZbWrRBGqf6jRl2dAuiJ8rANN9VOghO6Z7s/3c netology@netology"
  }
}

# старые переменные которые больше не используются
# variable "vms_ssh_root_key" {
#   type    = string
#   default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjzp2nZbWrRBGqf6jRl2dAuiJ8rANN9VOghO6Z7s/3c netology@netology"
# }