# deploy minio
kubectl create ns minio
kustomize build minio/ | kubectl -n minio apply -f -

# deploy argo
kubectl create ns argo
kustomize build argo-workflows/overlays/local/ | kubectl -n argo apply -f -

# create workflow sa for running workflows
kubectl apply -f wf-sa.yaml

# deploy argo-events
kubectl create ns argo-events
kustomize build argo-events/overlays/local/ | kubectl -n argo-events apply -f -

# add minio-secret to default ns
kubectl -n default apply -f minio/minio-cred-secret.yaml
