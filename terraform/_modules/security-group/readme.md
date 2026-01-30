# Security-Group

### main.tf

Cria um Security Group (aws_security_group.this) na VPC informada (var.vpc_id), com tags e create_before_destroy.

Usa var.create para permitir “desligar” a criação (com count).

Cria regras de Ingress de duas formas:por CIDR (aws_security_group_rule.ingress_with_cidr_blocks) por source security group (aws_security_group_rule.ingress_with_source_security_group_id)

Cria regras de Egress também em duas formas: por CIDR (aws_security_group_rule.egress_with_cidr_blocks) por source security group (aws_security_group_rule.egress_with_source_security_group_id)

O módulo é genérico: você passa listas de regras e a quantidade (number_of_*) para criar cada tipo.
Outputs: expõe security_group_id, metadados do SG (vpc_id, owner_id, name, description) e as regras ingress/egress.

### terraform/_modules/security-group/variables.tf (variáveis do módulo)

Define as entradas do módulo: create (boolean) para criar ou não vpc_id, name, description, tags

Define variáveis para regras: ingress_with_cidr_blocks, ingress_with_source_security_group_id, egress_with_cidr_blocks, egress_with_source_security_group_id e os contadores number_of_* para cada categoria. Também permite prefix_list_ids (útil para VPC endpoints).

### security-groups.tf (uso do módulo)

Instancia o módulo ./_modules/security-group como module "SG_EC2".

Cria um SG na VPC (module.VPC.vpc_id) com nome "sg EC2 instances".

Define 1 regra de ingress: Allow all de 0.0.0.0/0 protocol = -1 (todos protocolos) portas 0–65535 (todas)

Define 1 regra de egress: Allow all para 0.0.0.0/0 todos protocolos e todas portas

Aplica tags var.tags.