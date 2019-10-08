terraform {
  # Версия terraform
  required_version = "~>0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "2.15"

  # ID проекта
  project = var.project

  region = var.region
}

resource "google_compute_project_metadata_item" "project_ssh" {
  count = "${length(var.sshuser)}"
  key   = "ssh-keys"
  # Согласно заданию для упрощения используется общая переменная пути к файлу ключа для списка пользователей 
  value = join(" ", [for u in var.sshuser : "${u}:${file(var.pubkeypath)}"])
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["puma-server"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  metadata = {
    ssh-keys = "ak:${file(var.pubkeypath)}"
  }
  network_interface {
    network = "default"
    access_config {}
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "ak"
    agent = false
    # путь до приватного ключа
    private_key = file(var.prvkeypath)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "default-puma-server"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["puma-server"]
}


