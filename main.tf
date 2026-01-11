resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_groups" {
  for_each = var.firewall_policy_rule_collection_groups

  firewall_policy_id = each.value.firewall_policy_id
  name               = each.value.name
  priority           = each.value.priority

  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collection != null ? [each.value.application_rule_collection] : []
    content {
      action   = application_rule_collection.value.action
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      rule {
        description           = application_rule_collection.value.rule.description
        destination_addresses = application_rule_collection.value.rule.destination_addresses
        destination_fqdn_tags = application_rule_collection.value.rule.destination_fqdn_tags
        destination_fqdns     = application_rule_collection.value.rule.destination_fqdns
        destination_urls      = application_rule_collection.value.rule.destination_urls
        dynamic "http_headers" {
          for_each = application_rule_collection.value.rule.http_headers != null ? [application_rule_collection.value.rule.http_headers] : []
          content {
            name  = http_headers.value.name
            value = http_headers.value.value
          }
        }
        name = application_rule_collection.value.rule.name
        dynamic "protocols" {
          for_each = application_rule_collection.value.rule.protocols != null ? [application_rule_collection.value.rule.protocols] : []
          content {
            port = protocols.value.port
            type = protocols.value.type
          }
        }
        source_addresses = application_rule_collection.value.rule.source_addresses
        source_ip_groups = application_rule_collection.value.rule.source_ip_groups
        terminate_tls    = application_rule_collection.value.rule.terminate_tls
        web_categories   = application_rule_collection.value.rule.web_categories
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = each.value.nat_rule_collection != null ? [each.value.nat_rule_collection] : []
    content {
      action   = nat_rule_collection.value.action
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      rule {
        description         = nat_rule_collection.value.rule.description
        destination_address = nat_rule_collection.value.rule.destination_address
        destination_ports   = nat_rule_collection.value.rule.destination_ports
        name                = nat_rule_collection.value.rule.name
        protocols           = nat_rule_collection.value.rule.protocols
        source_addresses    = nat_rule_collection.value.rule.source_addresses
        source_ip_groups    = nat_rule_collection.value.rule.source_ip_groups
        translated_address  = nat_rule_collection.value.rule.translated_address
        translated_fqdn     = nat_rule_collection.value.rule.translated_fqdn
        translated_port     = nat_rule_collection.value.rule.translated_port
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collection != null ? [each.value.network_rule_collection] : []
    content {
      action   = network_rule_collection.value.action
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      rule {
        description           = network_rule_collection.value.rule.description
        destination_addresses = network_rule_collection.value.rule.destination_addresses
        destination_fqdns     = network_rule_collection.value.rule.destination_fqdns
        destination_ip_groups = network_rule_collection.value.rule.destination_ip_groups
        destination_ports     = network_rule_collection.value.rule.destination_ports
        name                  = network_rule_collection.value.rule.name
        protocols             = network_rule_collection.value.rule.protocols
        source_addresses      = network_rule_collection.value.rule.source_addresses
        source_ip_groups      = network_rule_collection.value.rule.source_ip_groups
      }
    }
  }
}

