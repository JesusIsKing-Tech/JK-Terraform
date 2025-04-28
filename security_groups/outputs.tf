output "sg_web_id" {
  value = aws_security_group.sg_web.id
}

output "sg_db_id" {
  value = aws_security_group.sg_db.id
}

output "sg_backend_id" {
  value = aws_security_group.sg_backend.id
}