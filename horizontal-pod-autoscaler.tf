# horizontal-pod-autoscaler

resource "helm_release" "hpa_operator" {
  depends_on = [
    var.module_depends_on
  ]
  count      = var.hpa_enabled
  name       = local.hpa_name
  repository = local.hpa_chart_repository
  chart      = local.hpa_chart
  version    = var.hpa_chart_version
  namespace  = local.namespace
  timeout    = 1200
  dynamic "set" {
    for_each = merge(local.hpa_conf_defaults, var.hpa_conf)

    content {
      name  = set.key
      value = set.value
    }
  }
}

locals {
  hpa_chart_repository = "https://kubernetes-charts.banzaicloud.com"
  hpa_name             = "hpa-operator"
  hpa_chart            = "hpa-operator"
  metrics_chart_repository = "https://charts.bitnami.com/bitnami"
  metrics_name             = "metrics-server"
  metrics_chart            = "metrics-server"

  hpa_conf = merge(local.hpa_conf_defaults, var.hpa_conf)
  hpa_conf_defaults = {
    "metrics-server.enabled"    = true,
    "rbac.create"               = true,
    "rbac.pspEnabled"           = true,
    "resources.limits.cpu"      = "100m",
    "resources.limits.memory"   = "30Mi",
    "resources.requests.cpu"    = "100m",
    "resources.requests.memory" = "30Mi",
  }
}
