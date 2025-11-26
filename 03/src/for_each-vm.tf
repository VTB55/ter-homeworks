variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 15
    },
    {
      vm_name     = "replica" 
      cpu         = 4
      ram         = 4
      disk_volume = 25
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }
  
  name        = each.value.vm_name
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_key}"
  }
}