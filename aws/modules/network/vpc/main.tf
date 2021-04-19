/*Red Privada*/
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
   #tags
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-vpc"
    }
  )  
}

/* Internet gateway */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-ig"
    }
  )  
  # Depende de VPC
  depends_on = [aws_vpc.main]
}
/* Subnet Publica*/
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.vpc_azs, count.index)
  map_public_ip_on_launch = true 
 
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-public-subnet-${count.index}"
    }
  )  
}

/* Subnet Privada*/
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_subnet_cidrs)
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.vpc_azs, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-private-subnet-${count.index}"
    }
  )  
}

/* RouteTable Privada */ 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-route-table-private"
    }
  )  
  # Depende de VPC
  depends_on = [aws_vpc.main]
}

/* RouteTable Default */ 
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  /*Route to Internet*/
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-route-table-default"
    }
  )  
  # Depende de Internet Gateway
  depends_on = [aws_internet_gateway.ig]
}

/* RouteTable Publica */ 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

   /*Route to Internet*/
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-route-table-public"
    }
  )  
  # Depende de Internet Gateway
  depends_on = [aws_vpc.main]
  # Ignora las rutas
  lifecycle {
    ignore_changes = [ route ]
  }
}

/* Association Route Table Publica*/
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

/* Association Route Table Privada*/
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

/* ACL Privada*/
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id
  # Habilita salida a Internet
  egress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  # Habilita el ingreso a Internet
  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-acl-private"
    }
  )  
}

/* Elastic IP for NAT */
resource "aws_eip" "eip" {
  vpc        = true
  # Depende Internet Gateway
  depends_on = [aws_internet_gateway.ig]
}

/* NAT Gateway*/
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_eip.eip, aws_subnet.public]

  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-nat"
    }
  )  
}
/*Route to Internet*/
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}