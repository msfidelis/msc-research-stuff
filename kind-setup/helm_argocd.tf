resource "helm_release" "argocd" {

  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"


  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"
  }

  set {
    name  = "server.extensions.enabled"
    value = "true"
  }

  set {
    name  = "server.enable.proxy.extension"
    value = "true"
  }

  set {
    name  = "server.extensions.image.repository"
    value = "quay.io/argoprojlabs/argocd-extension-installer"
  }

  set {
    name  = "server.extensions.extensionList[0].name"
    value = "rollout-extension"
  }

  set {
    name  = "server.extensions.extensionList[0].env[0].name"
    value = "EXTENSION_URL"
  }

  set {
    name  = "server.extensions.extensionList[0].env[0].value"
    value = "https://github.com/argoproj-labs/rollout-extension/releases/download/v0.3.6/extension.tar"
  }      

}

resource "kubectl_manifest" "argo_gateway" {

  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: argocd-gateway
  namespace: argocd
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - argocd.cluster.io
YAML

  depends_on = [
    helm_release.argocd,
    helm_release.istio_base,
    helm_release.istiod
  ]

}


resource "kubectl_manifest" "argocd_virtual_service" {

  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: argo-server
  namespace: argocd
spec:
  hosts:
  - argocd.cluster.io
  gateways:
  - argocd-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: argocd-server
        port:
          number: 80
YAML

  depends_on = [
    helm_release.argocd,
    helm_release.istio_base,
    helm_release.istiod
  ]

}