# Local переменные для имен ВМ
locals {
  # Имя WEB ВМ с использованием интерполяции нескольких переменных
  vm_web_name = "${var.vm_web_name}-${var.yandex_zone}-${random_id.suffix.hex}"
  
  # Имя DB ВМ с использованием интерполяции нескольких переменных  
  vm_db_name = "${var.vm_db_name}-${var.vm_db_zone}-${random_id.suffix.hex}"
}

# Создаем random suffix для уникальности имен
resource "random_id" "suffix" {
  byte_length = 4
}