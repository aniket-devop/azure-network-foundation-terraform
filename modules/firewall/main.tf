locals {
  spoke_names = sort(keys(var.spoke_address_spaces))

  # Every spoke range. Used to block traffic from one spoke to the others.
  all_spoke_ranges = flatten(values(var.spoke_address_spaces))

  # Spoke egress is allowed only to these FQDNs for now. Extend per need.
  allowed_fqdns = [
    "*.azmk8s.io",
    "mcr.microsoft.com",
    "*.data.mcr.microsoft.com",
    "management.azure.com",
    "login.microsoftonline.com",
  ]
}

resource "azurerm_public_ip" "firewall" {
  name                = "pip-${var.firewall_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_firewall_policy" "this" {
  name                = "afwp-${var.firewall_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_tier
  tags                = var.tags
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "AZFW_VNet"
  sku_tier            = var.sku_tier
  firewall_policy_id  = azurerm_firewall_policy.this.id
  tags                = var.tags

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

# One rule collection group per spoke. Deny rules have a lower priority number,
# so they are evaluated before the allow rules.
resource "azurerm_firewall_policy_rule_collection_group" "spoke" {
  for_each = var.spoke_address_spaces

  name               = "rcg-${each.key}"
  firewall_policy_id = azurerm_firewall_policy.this.id
  priority           = 200 + (index(local.spoke_names, each.key) * 100)

  network_rule_collection {
    name     = "deny-spoke-to-spoke"
    priority = 110
    action   = "Deny"

    rule {
      name                  = "deny-to-all-spokes"
      protocols             = ["Any"]
      source_addresses      = each.value
      destination_addresses = local.all_spoke_ranges
      destination_ports     = ["*"]
    }
  }

  network_rule_collection {
    name     = "allow-dns"
    priority = 210
    action   = "Allow"

    rule {
      name                  = "allow-dns-out"
      protocols             = ["UDP"]
      source_addresses      = each.value
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
  }

  application_rule_collection {
    name     = "allow-https-fqdn"
    priority = 310
    action   = "Allow"

    rule {
      name              = "allow-listed-fqdns"
      source_addresses  = each.value
      destination_fqdns = local.allowed_fqdns

      protocols {
        type = "Https"
        port = 443
      }
    }
  }
}
