## VPC
Modulo que declara los recursos necesarios para implementar una red privada con las caracteristicas de alta disponibilidad, mantenimiento y buenas practicas.

### Entradas
Son las entradas que son definidas en la plantilla:

| Variable | Valor Default | Descripción |
| -- | -- | -- |
| environment | env | Tipo de Ambiente |
| region | us-west-1 | Region de dominante de implementación |
| application | acme | Nombre de la aplicación o sistema que se implementará |
| tags | {}  | Mapa con tags generales para relacionar en cada recurso |
| cidr_block | 172.0.0.0/16 | CIDR Block de la red privada |
| public_subnet_cidrs | {"172.0.1.0/26","172.0.2.0/26"} | Lista de CIDR de subnets publicas |
| private_subnet_cidrs | {"172.0.3.0/26","172.0.4.0/26"} | Lista de CIDR de subnets privadas |
| vpc_azs | {"us-west-1a", "us-west-1b"} | Lista de AZ que se le asignan a la red privada |


### Salidas
Son las salidas que se generarán al finalizar la ejecución de la plantilla.

| Variable | Descripción |
| -- | -- |
| vpc_id | Identificador de VPC |
| vpc_arm | ARN de VPC |
| private_subnet_ids | Lista de identificadores de subnets privadas |
| public_subnet_ids | Lista de identificadores de subnets publicas |
| private_route_table_id | Identificador de tabla de ruteo privada |
| public_route_table_id | Identificador de tabla de ruteo publica |
| owner_id | Numero de cuenta donde se creo la VPC |











