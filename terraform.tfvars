name                      = "HighCPUUtilizationAlert"
resource_group_name       = "your-resource-group"
enabled                   = true
auto_mitigate             = true
description               = "Alert for high CPU utilization"
frequency                 = "PT1M"
severity                  = 2
target_resource_type      = "Microsoft.Compute/virtualMachines"
target_resource_location  = "East US"
window_size               = "PT5M"

scopes = [
  "/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Compute/virtualMachines/vm1",
  "/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Compute/virtualMachines/vm2",
]

criteria_vm = [
  {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
    dimension = [
      {
        name     = "ResourceId"
        operator = "GreaterThan"
        values   = ["/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Compute/virtualMachines/vm1"]
      }
    ]
  },
  {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
    dimension = [
      {
        name     = "ResourceId"
        operator = "GreaterThan"
        values   = ["/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Compute/virtualMachines/vm2"]
      }
    ]
  }
]

dynamic_criteria = [
  {
    metric_namespace        = "Microsoft.Storage/storageAccounts"
    metric_name             = "UsedCapacity"
    aggregation             = "Average"
    operator                = "GreaterThan"
    threshold               = 80
    alert_sensitivity       = "High"
    evaluation_total_count  = 4
    evaluation_failure_count = 3
    dimension = [
      {
        name     = "ResourceId"
        operator = "Include"
        values   = ["/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Storage/storageAccounts/storageaccount1"]
      }
    ]
  }
]

action = [
  {
    action_group_id = "/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.Insights/actionGroups/your-action-group"
    webhook_properties = [
      {
        url = "https://example.com/alert"
      }
    ]
  }
]
