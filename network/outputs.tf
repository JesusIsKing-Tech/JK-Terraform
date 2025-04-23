output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID da sub-rede pública"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID da sub-rede privada"
  value       = aws_subnet.private.id
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "ID do NAT Gateway criado"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "ID do Internet Gateway criado"
}