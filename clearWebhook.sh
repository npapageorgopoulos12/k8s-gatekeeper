#!/bin/bash

# Delete Kubernetes resources in the reverse order of their application
kubectl delete -f config/webhook_internal.yaml
kubectl delete -f config/webhook_deployment.yaml
kubectl delete -f config/rbac.yaml

echo "Deletion complete."
