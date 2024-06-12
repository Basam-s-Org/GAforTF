
### Instaclustr Provider User and Key Credentials

variable "instaclustr_api_cred" {
  type = string
}


### Resource Variables

# Azure Resource Group Name

variable "rg_name" {
  type = string
}

# Azure Resource Location

variable "rg_location" {
  type    = string
}

# cluster_id: ID of luster to which allow list to be added

variable "cluster_id"{
  type    = string
}

# firewall_rules: Firewall Allow CIDR list

variable "firewall_rules"{
  type    = list
}

