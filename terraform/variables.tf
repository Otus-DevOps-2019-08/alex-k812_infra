variable project {
  description = "Project ID"
}
variable region {
  description = "Default instance region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable pubkeypath {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable prvkeypath {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable zone {
  default     = "europe-west1-b"
  description = "Default instance zone"
}
variable sshuser {
  type = list(string)
}