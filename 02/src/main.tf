data "yandex_vpc_subnet" "develop_web" {
  name = "default-ru-central1-d"
}

data "yandex_vpc_subnet" "develop_db" {
  name = "default-ru-central1-b"
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family_image
}

# WEB ВМ
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  zone        = var.yandex_zone
  
  # ИСПОЛЬЗУЮ НОВУЮ MAP ПЕРЕМЕННУЮ
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  
  network_interface {
    subnet_id = data.yandex_vpc_subnet.develop_web.id
    nat       = true
  }

  # ИСПОЛЬЗУЮ ОБЩУЮ METADATA ДЛЯ ВСЕХ ВМ
  metadata = var.vm_metadata
}

# DB ВМ
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  
  # ИСПОЛЬЗУЮ НОВУЮ MAP ПЕРЕМЕННУЮ
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  
  network_interface {
    subnet_id = data.yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  # ИСПОЛЬЗУЮ ОБЩУЮ METADATA ДЛЯ ВСЕХ ВМ
  metadata = var.vm_metadata
}