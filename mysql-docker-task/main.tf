terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "docker" {}

resource "random_password" "mysql_root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_user_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql-${random_password.mysql_root_password.result}"
  
  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress", 
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]

  restart = "unless-stopped"
}