variable "firewall_policy_rule_collection_groups" {
  description = <<EOT
Map of firewall_policy_rule_collection_groups, attributes below
Required:
    - firewall_policy_id
    - name
    - priority
Optional:
    - application_rule_collection (block):
        - action (required)
        - name (required)
        - priority (required)
        - rule (required, block):
            - description (optional)
            - destination_addresses (optional)
            - destination_fqdn_tags (optional)
            - destination_fqdns (optional)
            - destination_urls (optional)
            - http_headers (optional, block):
                - name (required)
                - value (required)
            - name (required)
            - protocols (optional, block):
                - port (required)
                - type (required)
            - source_addresses (optional)
            - source_ip_groups (optional)
            - terminate_tls (optional)
            - web_categories (optional)
    - nat_rule_collection (block):
        - action (required)
        - name (required)
        - priority (required)
        - rule (required, block):
            - description (optional)
            - destination_address (optional)
            - destination_ports (optional)
            - name (required)
            - protocols (required)
            - source_addresses (optional)
            - source_ip_groups (optional)
            - translated_address (optional)
            - translated_fqdn (optional)
            - translated_port (required)
    - network_rule_collection (block):
        - action (required)
        - name (required)
        - priority (required)
        - rule (required, block):
            - description (optional)
            - destination_addresses (optional)
            - destination_fqdns (optional)
            - destination_ip_groups (optional)
            - destination_ports (required)
            - name (required)
            - protocols (required)
            - source_addresses (optional)
            - source_ip_groups (optional)
EOT

  type = map(object({
    firewall_policy_id = string
    name               = string
    priority           = number
    application_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = number
      rule = list(object({
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_urls      = optional(list(string))
        http_headers = optional(list(object({
          name  = string
          value = string
        })))
        name = string
        protocols = optional(list(object({
          port = number
          type = string
        })))
        source_addresses = optional(list(string))
        source_ip_groups = optional(list(string))
        terminate_tls    = optional(bool)
        web_categories   = optional(list(string))
      }))
    })))
    nat_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = number
      rule = list(object({
        description         = optional(string)
        destination_address = optional(string)
        destination_ports   = optional(list(string))
        name                = string
        protocols           = list(string)
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        translated_address  = optional(string)
        translated_fqdn     = optional(string)
        translated_port     = number
      }))
    })))
    network_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = number
      rule = list(object({
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = list(string)
        name                  = string
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      }))
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.application_rule_collection == null || (length(v.application_rule_collection) >= 1)
      )
    ])
    error_message = "Each application_rule_collection list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.application_rule_collection == null || alltrue([for item in v.application_rule_collection : (length(item.rule) >= 1)])
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.nat_rule_collection == null || (length(v.nat_rule_collection) >= 1)
      )
    ])
    error_message = "Each nat_rule_collection list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.nat_rule_collection == null || alltrue([for item in v.nat_rule_collection : (length(item.rule) >= 1)])
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.network_rule_collection == null || (length(v.network_rule_collection) >= 1)
      )
    ])
    error_message = "Each network_rule_collection list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_policy_rule_collection_groups : (
        v.network_rule_collection == null || alltrue([for item in v.network_rule_collection : (length(item.rule) >= 1)])
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_firewall_policy_rule_collection_group's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    validate.FirewallPolicyRuleCollectionGroupName: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: firewall_policy_id
  #   source:    [from firewallpolicies.ValidateFirewallPolicyID] !ok
  # path: firewall_policy_id
  #   source:    [from firewallpolicies.ValidateFirewallPolicyID] err != nil
  # path: priority
  #   condition: value >= 100 && value <= 65000
  #   message:   must be between 100 and 65000
  # path: application_rule_collection.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.priority
  #   condition: value >= 100 && value <= 65000
  #   message:   must be between 100 and 65000
  # path: application_rule_collection.action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: application_rule_collection.rule.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.description
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.protocols.type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: application_rule_collection.rule.protocols.port
  #   condition: value >= 0 && value <= 64000
  #   message:   must be between 0 and 64000
  # path: application_rule_collection.rule.http_headers.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.http_headers.value
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.source_addresses[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: application_rule_collection.rule.source_ip_groups[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.destination_addresses[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: application_rule_collection.rule.destination_fqdns[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.destination_urls[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.destination_fqdn_tags[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: application_rule_collection.rule.web_categories[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.priority
  #   condition: value >= 100 && value <= 65000
  #   message:   must be between 100 and 65000
  # path: network_rule_collection.action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: network_rule_collection.rule.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.description
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.protocols[*]
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: network_rule_collection.rule.source_addresses[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: network_rule_collection.rule.source_ip_groups[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.destination_addresses[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.destination_ip_groups[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.destination_fqdns[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: network_rule_collection.rule.destination_ports[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: nat_rule_collection.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: nat_rule_collection.priority
  #   condition: value >= 100 && value <= 65000
  #   message:   must be between 100 and 65000
  # path: nat_rule_collection.action
  #   condition: contains(["Dnat"], value)
  #   message:   must be one of: Dnat
  # path: nat_rule_collection.rule.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: nat_rule_collection.rule.description
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: nat_rule_collection.rule.protocols[*]
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: nat_rule_collection.rule.source_addresses[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: nat_rule_collection.rule.source_ip_groups[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: nat_rule_collection.rule.destination_address
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: nat_rule_collection.rule.destination_ports[*]
  #   source:    [from validate.PortOrPortRangeWithin] !ok
  # path: nat_rule_collection.rule.destination_ports[*]
  #   condition: length(value) == 5
  #   message:   [from validate.PortOrPortRangeWithin: invalid when len(value) != 5]
  #   source:    [from validate.PortOrPortRangeWithin: invalid when len(value) != 5]
  # path: nat_rule_collection.rule.destination_ports[*]
  #   condition: length(value) > 0
  #   message:   [from validate.PortOrPortRangeWithin: invalid when value == ""]
  #   source:    [from validate.PortOrPortRangeWithin: invalid when value == ""]
  # path: nat_rule_collection.rule.destination_ports[*]
  #   source:    [from validate.PortOrPortRangeWithin] err != nil
  # path: nat_rule_collection.rule.destination_ports[*]
  #   source:    [from validate.PortOrPortRangeWithin] p1 >= p2
  # path: nat_rule_collection.rule.destination_ports[*]
  #   source:    [from validate.PortOrPortRangeWithin] err != nil
  # path: nat_rule_collection.rule.destination_ports[*]
  #   source:    [from validate.PortOrPortRangeWithin] err != nil
  # path: nat_rule_collection.rule.translated_address
  #   source:    validation.IsIPAddress(...) - no translation rule yet, add one
  # path: nat_rule_collection.rule.translated_port
  #   source:    validation.IsPortNumber(...) - no translation rule yet, add one
  # path: nat_rule_collection.rule.translated_fqdn
  #   condition: length(value) > 0
  #   message:   must not be empty
}

