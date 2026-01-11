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
    application_rule_collection = optional(object({
      action   = string
      name     = string
      priority = number
      rule = object({
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_urls      = optional(list(string))
        http_headers = optional(object({
          name  = string
          value = string
        }))
        name = string
        protocols = optional(object({
          port = number
          type = string
        }))
        source_addresses = optional(list(string))
        source_ip_groups = optional(list(string))
        terminate_tls    = optional(bool)
        web_categories   = optional(list(string))
      })
    }))
    nat_rule_collection = optional(object({
      action   = string
      name     = string
      priority = number
      rule = object({
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
      })
    }))
    network_rule_collection = optional(object({
      action   = string
      name     = string
      priority = number
      rule = object({
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = list(string)
        name                  = string
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })
    }))
  }))
}

