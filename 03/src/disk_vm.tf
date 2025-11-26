resource "yandex_compute_disk" "storage_disks" {
  count = 3
  
  name     = "storage-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1
  
  labels = {
    environment = "development"
    task        = "storage"
  }
}

# Создаем одиночную ВМ "storage" 
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id # Ubuntu 20.04
      size     = 10
    }
  }

  # Динамическое подключение дополнительных дисков
  dynamic "secondary_disk" {
    for_each = { for disk in yandex_compute_disk.storage_disks : disk.id => disk }
    
    content {
      disk_id = secondary_disk.value.id
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
