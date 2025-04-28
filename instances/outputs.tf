output "web_instance_id" {
  description = "ID da instância pública (Web)"
  value       = aws_instance.web.id
}

output "web_instance_public_ip" {
  description = "Endereço IP público da instância web"
  value       = aws_instance.web.public_ip
}

output "db_instance_id" {
  description = "ID da instância privada (Banco de Dados)"
  value       = aws_instance.db.id
}

output "db_instance_private_ip" {
  description = "Endereço IP privado da instância de banco de dados"
  value       = aws_instance.db.private_ip
}

output "backend_instance_id" {
  description = "ID da instância privada (Backend)"
  value       = aws_instance.backend.id
}

output "backend_instance_private_ip" {
  description = "Endereço IP privado da instância Backend"
  value       = aws_instance.backend.private_ip
}