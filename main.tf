module "monitoring" {
  source = "./monitoring"
  name                      = var.name
  resource_group_name       = var.resource_group_name
  scopes                    = var.scopes
  dynamic_criteria          = var.dynamic_criteria
  action                    = var.action
  enabled                   = var.enabled
  auto_mitigate             = var.auto_mitigate
  description               = var.description
  frequency                 = var.frequency
  severity                  = var.severity
  target_resource_type      = var.target_resource_type
  target_resource_location  = var.target_resource_location
  window_size               = var.window_size
}
