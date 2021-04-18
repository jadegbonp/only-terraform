# Salidas del stack
output "instance_public_ip" {
  value       = aws_spot_instance_request.cheap_instance.public_ip
  description = "Ip publica de la instancia Spot"
}
output "instance_public_dns" {
  value       = aws_spot_instance_request.cheap_instance.public_dns
  description = "Dms publico de la instancia Spot"
}

