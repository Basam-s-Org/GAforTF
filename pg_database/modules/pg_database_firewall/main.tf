# Define firewall rules for an Instaclustr cluster
resource "instaclustr_cluster_network_firewall_rules_v2" "example" {
  # Only create resource if there is at least one firewall rule defined
  count = length(var.firewall_rules) == 0 ? 0 : 1

  cluster_id = var.cluster_id  # ID of the cluster

  dynamic "firewall_rule" {
    for_each = var.firewall_rules  # Iterate over firewall rules
    content {
      network = firewall_rule.value  # Network address for the rule
      type    = "POSTGRESQL"         # Type of the rule
    }
  }
}
