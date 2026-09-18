resource "helm_release" "main" {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository = var.repository
  chart      = var.chart
  version    = var.chart_version

  values = var.values
  set    = var.set

  atomic          = var.atomic
  cleanup_on_fail = var.cleanup_on_fail
  wait            = var.wait
  wait_for_jobs   = var.wait_for_jobs
  timeout         = var.timeout
  max_history     = var.max_history
  skip_crds       = var.skip_crds
}
