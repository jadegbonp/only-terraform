/*Lista de salidas del modulo*/
output "vpc_id" {
    value       = aws_vpc.main.id
    description = "Identificar de VPC" 
}
output "vpc_arm" {
    value       = aws_vpc.main.arn
    description = "Identificar unico de AWS de VPC" 
}
output "private_subnet_ids" {
    value = aws_subnet.private.*.id  
    description = "Lista de identificadores de subnets privadas" 
}
output "public_subnet_ids" {
    value       = aws_subnet.public.*.id
    description = "Lista de identificadores de subnets publicas"
}
output "private_route_table_id" {
    value       = aws_route_table.private.id
    description = "Identificador de tabla de ruteo privada"
}
output "public_route_table_id" {
    value       = aws_route_table.public.id
    description = "Identificador de tabla de ruteo publica"
}
output "owner_id" {
    value       = aws_vpc.main.owner_id
    description = "Numero de cuenta de AWS dueña de la VPC" 
}
