resource "azurerm_monitor_metric_alert" "metric_alert" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  enabled             = var.enabled
  auto_mitigate       = var.auto_mitigate
  frequency           = var.frequency
  severity            = var.severity
  target_resource_type      = var.target_resource_type
  target_resource_location  = var.target_resource_location
  window_size         = var.window_size

  dynamic "action" {
    for_each = var.action

    content {
      action_group_id = action.value["action_group_id"]
    }
  }

  dynamic "criteria" {
    for_each = var.criteria_vm

    content {
      metric_namespace = "Microsoft.Compute/virtualMachines"
      metric_name      = criteria.value["metric_name"]
      aggregation      = criteria.value["aggregation"]
      operator         = criteria.value["operator"]
      threshold        = criteria.value["threshold"]

      dynamic "dimension" {
        for_each = criteria.value["dimension"]

        content {
          name     = dimension.value["name"]
          operator = dimension.value["operator"]
          values   = dimension.value["values"]
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = var.dynamic_criteria

    content {
      metric_namespace        = dynamic_criteria.value["metric_namespace"]
      metric_name             = dynamic_criteria.value["metric_name"]
      aggregation             = dynamic_criteria.value["aggregation"]
      operator                = dynamic_criteria.value["operator"]
      alert_sensitivity       = dynamic_criteria.value["alert_sensitivity"]
      evaluation_total_count  = dynamic_criteria.value["evaluation_total_count"]
      evaluation_failure_count = dynamic_criteria.value["evaluation_failure_count"]

      dynamic "dimension" {
        for_each = dynamic_criteria.value["dimension"]

        content {
          name     = dimension.value["name"]
          operator = dimension.value["operator"]
          values   = dimension.value["values"]
        }
      }
    }
  }
}
