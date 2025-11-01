# Output для WEB ВМ
output "web_vm_info" {
  description = "Информация о WEB виртуальной машине"
  value = {
    instance_name = yandex_compute_instance.platform.name
    external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    internal_ip   = yandex_compute_instance.platform.network_interface.0.ip_address
    fqdn          = yandex_compute_instance.platform.fqdn
    zone          = yandex_compute_instance.platform.zone
    local_name    = local.vm_web_name  # ← ДОБАВИЛИ local имя
  }
}

# Output для DB ВМ  
output "db_vm_info" {
  description = "Информация о DB виртуальной машине"
  value = {
    instance_name = yandex_compute_instance.platform_db.name
    external_ip   = yandex_compute_instance.platform_db.network_interface.0.nat_ip_address
    internal_ip   = yandex_compute_instance.platform_db.network_interface.0.ip_address
    fqdn          = yandex_compute_instance.platform_db.fqdn
    zone          = yandex_compute_instance.platform_db.zone
    local_name    = local.vm_db_name  # ← ДОБАВИЛИ local имя
  }
}

# Output для local переменных
output "local_names" {
  description = "Local имена ВМ"
  value = {
    vm_web_name = local.vm_web_name
    vm_db_name  = local.vm_db_name
  }
}