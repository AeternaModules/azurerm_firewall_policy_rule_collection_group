output "firewall_policy_rule_collection_groups" {
  description = "All firewall_policy_rule_collection_group resources"
  value       = azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups
}
output "firewall_policy_rule_collection_groups_application_rule_collection" {
  description = "List of application_rule_collection values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.application_rule_collection]
}
output "firewall_policy_rule_collection_groups_firewall_policy_id" {
  description = "List of firewall_policy_id values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.firewall_policy_id]
}
output "firewall_policy_rule_collection_groups_name" {
  description = "List of name values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.name]
}
output "firewall_policy_rule_collection_groups_nat_rule_collection" {
  description = "List of nat_rule_collection values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.nat_rule_collection]
}
output "firewall_policy_rule_collection_groups_network_rule_collection" {
  description = "List of network_rule_collection values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.network_rule_collection]
}
output "firewall_policy_rule_collection_groups_priority" {
  description = "List of priority values across all firewall_policy_rule_collection_groups"
  value       = [for k, v in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_groups : v.priority]
}

