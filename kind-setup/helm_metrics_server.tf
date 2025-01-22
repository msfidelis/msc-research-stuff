resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait       = false

  version = "7.3.0"

  set {
    name  = "apiService.create"
    value = "true"
  }

  depends_on = [
  ]
}