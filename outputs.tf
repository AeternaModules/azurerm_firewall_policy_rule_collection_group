output "firewall_policy_rule_collection_groups_id" {
  description = "Map of id values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.id if v.id != null && length(v.id) > 0 }
}
output "firewall_policy_rule_collection_groups_application_rule_collection" {
  description = "Map of application_rule_collection values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.application_rule_collection if v.application_rule_collection != null && length(v.application_rule_collection) > 0 }
}
output "firewall_policy_rule_collection_groups_firewall_policy_id" {
  description = "Map of firewall_policy_id values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.firewall_policy_id if v.firewall_policy_id != null && length(v.firewall_policy_id) > 0 }
}
output "firewall_policy_rule_collection_groups_name" {
  description = "Map of name values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.name if v.name != null && length(v.name) > 0 }
}
output "firewall_policy_rule_collection_groups_nat_rule_collection" {
  description = "Map of nat_rule_collection values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.nat_rule_collection if v.nat_rule_collection != null && length(v.nat_rule_collection) > 0 }
}
output "firewall_policy_rule_collection_groups_network_rule_collection" {
  description = "Map of network_rule_collection values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.network_rule_collection if v.network_rule_collection != null && length(v.network_rule_collection) > 0 }
}
output "firewall_policy_rule_collection_groups_priority" {
  description = "Map of priority values across all firewall_policy_rule_collection_groups, keyed the same as var.firewall_policy_rule_collection_groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : k => v.priority if v.priority != null }
}

