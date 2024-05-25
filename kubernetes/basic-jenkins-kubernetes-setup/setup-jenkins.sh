#!/bin/bash

# Apply Namespace
kubectl apply -f jenkins-namespace.yaml

# Apply Persistent Volume
kubectl apply -f jenkins-pv.yaml

# Apply Persistent Volume Claim
kubectl apply -f jenkins-pvc.yaml

# Apply Deployment
kubectl apply -f jenkins-deployment.yaml

# Apply Service
kubectl apply -f jenkins-service.yaml

echo "Jenkins setup on Kubernetes completed."
