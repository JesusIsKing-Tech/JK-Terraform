variable "ssh_key_name" {
  description = "Nome do Key Pair para acesso SSH"
  type        = string
  default = "mysshkey"
}

variable "ssh_private_key_path" {
  description = "Caminho para a chave SSH privada"
  type        = string
  default = "C:/Users/marce/Documents/SPtech/4-semestre/sprint/key-ssh/mysshkey.pem"
}