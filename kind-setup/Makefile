.PHONY: create delete kind terraform argocd-password


create: kind terraform chart argocd-password
	kubectl cluster-info --context kind-kind

kind:
	kind create cluster --config config.yaml
	kubectl cluster-info --context kind-kind

delete: 
	kind delete cluster

terraform: 
	terraform init
	terraform apply --auto-approve

argocd-password:
	echo; kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

chart:
	helm package helm/sample --destination helm/
	curl --data-binary "@helm/sample-0.1.0.tgz" http://chartmuseum.cluster.io:30080/api/charts 