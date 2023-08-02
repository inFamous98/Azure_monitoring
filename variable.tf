variable "name" {
  description = "The name of the Metric Alert."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Metric Alert instance."
  type        = string
}

variable "scopes" {
  description = "A set of strings of resource IDs at which the metric criteria should be applied."
  type        = list(string)
}

variable "description" {
  description = "The description of this Metric Alert."
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Should this Metric Alert be enabled?"
  type        = bool
  default     = true
}

variable "auto_mitigate" {
  description = "Should the alerts in this Metric Alert be auto resolved?"
  type        = bool
  default     = true
}

variable "frequency" {
  description = "The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format."
  type        = string
  default     = "PT1M"
}

variable "severity" {
  description = "The severity of this Metric Alert."
  type        = number
  default     = 3
}

variable "target_resource_type" {
  description = "The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource."
  type        = string
}

variable "target_resource_location" {
  description = "The location of the target resource."
  type        = string
}

variable "window_size" {
  description = "The period of time that is used to monitor alert activity, represented in ISO 8601 duration format."
  type        = string
  default     = "PT5M"
}

variable "action" {
  description = "One or more action blocks as defined below."
  type        = list(object({
    action_group_id     = string
    webhook_properties  = list(object({
      url = string
    }))
  }))
  default     = []
}

variable "criteria_vm" {
  description = "Criteria block for VMs. One or more (static) criteria blocks as defined below."
  type        = list(object({
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
    dimension        = list(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
  default     = []
}

variable "dynamic_criteria" {
  description = "Dynamic criteria block for storage accounts. One or more (dynamic) criteria blocks as defined below."
  type        = list(object({
    metric_namespace        = string
    metric_name             = string
    aggregation             = string
    operator                = string
    alert_sensitivity       = string
    evaluation_total_count  = number
    evaluation_failure_count = number
    dimension               = list(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
  default     = []
}

variable "app_insights_web_test_criteria" {
  description = "Application Insights Web Test Location Availability criteria block. One or more (static) criteria blocks as defined below."
  type        = list(object({
    web_test_id            = string
    component_id           = string
    failed_location_count  = number
  }))
  default     = []
}
