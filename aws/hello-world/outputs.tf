
# Salidas del stack
output "instance_public_ip" {
  value       = module.ec2_spot_instance.instance_public_ip
  description = "Ip publica de la instancia Spot"
}
output "instance_public_dns" {
  value       = module.ec2_spot_instance.instance_public_dns
  description = "Dms publico de la instancia Spot"
}