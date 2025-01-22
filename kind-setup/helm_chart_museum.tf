resource "helm_release" "chart_museum" {

  name             = "chartmuseum"
  namespace        = "chartmuseum"
  create_namespace = true

  repository = "https://chartmuseum.github.io/charts"
  chart      = "chartmuseum"

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "env.open.DISABLE_API"
    value = "false"
  }

  set {
    name  = "env.open.STORAGE"
    value = "local"
  }

  set {
    name  = "env.open.DEBUG"
    value = "true"
  }

  set {
    name  = "env.open.DISABLE_STATEFILES"
    value = "true"
  }

}

resource "kubectl_manifest" "chartmuseum_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: chartmuseum-gateway
  namespace: chartmuseum
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - chartmuseum.cluster.io
YAML

  depends_on = [
    helm_release.chart_museum,
    helm_release.istio_base,
    helm_release.istiod
  ]

}

resource "kubectl_manifest" "chartmuseum_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: chartmuseum
  namespace: chartmuseum
spec:
  hosts:
  - chartmuseum.cluster.io
  gateways:
  - chartmuseum-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: chartmuseum
        port:
          number: 8080
YAML

  depends_on = [
    helm_release.chart_museum,
    helm_release.istio_base,
    helm_release.istiod
  ]

}