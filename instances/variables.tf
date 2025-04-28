variable "public_subnet_id" {
  description = "ID da sub-rede pública para a instância web"
  type        = string
}

variable "private_subnet_id" {
  description = "ID da sub-rede privada para a instância de banco de dados"
  type        = string
}

variable "sg_web_id" {
  description = "ID do security group para a instância web"
  type        = string
}

variable "sg_db_id" {
  description = "ID do security group para a instância de banco de dados"
  type        = string
}

variable "sg_backend_id" {
  description = "ID do security group para a instância backend"
  type        = string
}

variable "ssh_key_name" {
  description = "Nome do Key Pair para acesso SSH"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Caminho para a chave SSH privada"
  type        = string
}