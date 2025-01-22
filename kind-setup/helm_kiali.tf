resource "helm_release" "kiali-server" {
  name             = "kiali-server"
  chart            = "kiali-server"
  repository       = "https://kiali.org/helm-charts"
  namespace        = "istio-system"
  create_namespace = true

  version = "1.79.0"

  set {
    name  = "server.web_fqdn"
    value = "kiali.cluster.io"
  }

  set {
    name  = "auth.strategy"
    value = "anonymous"
  }

#   set {
#     name  = "external_services.tracing.enabled"
#     value = true
#   }

#   set {
#     name  = "external_services.tracing.in_cluster_url"
#     value = "http://jaeger-query.jaeger.svc.cluster.local:80"
#   }

  set {
    name  = "external_services.tracing.use_grpc"
    value = false
  }

  set {
    name  = "external_services.prometheus.url"
    value = "http://prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local:9090"
  }

  set {
    name  = "external_services.grafana.enabled"
    value = true
  }

  set {
    name  = "external_services.grafana.url"
    value = "http://prometheus-grafana.prometheus.svc.cluster.local:80"
  }


  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]
}


resource "kubectl_manifest" "kiali_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - kiali.cluster.io
YAML

  depends_on = [
    helm_release.kiali-server,
    helm_release.istio_base,
    helm_release.istiod
  ]

}

resource "kubectl_manifest" "kiali_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali
  namespace: istio-system
spec:
  hosts:
  - kiali.cluster.io
  gateways:
  - kiali-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: kiali
        port:
          number: 20001
YAML

  depends_on = [
    helm_release.kiali-server,
    helm_release.istio_base,
    helm_release.istiod
  ]

}