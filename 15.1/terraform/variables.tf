# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = ""
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = ""
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "ubuntu" {
  default = "fd80d7fnvf399b1c207j"
}

variable "centos7" {
  default = "fd8ic5bmgr51h6e7bh1v"
}

variable "nat" {
  default = "fd80mrhj8fl2oe87o4e1"
}

# Указываем токен аутентификации
variable "oauth_token" {
  type = string
  default = ""
}
