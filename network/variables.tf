variable "vpc_cidr" {
    description = "CIDR principal da VPC"
    type = string
    default = "10.0.0.0/24"
}

variable "public_subnet_cidr" {
    description = "CIDR da sub-rede pública"
    type = string
    default = "10.0.0.0/25"
}

variable "private_subnet_cidr" {
    description = "CIDR da sub-rede privada"
    type = string
    default = "10.0.0.128/25"
}