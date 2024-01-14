#!/bin/bash

# Paths to your original kubeconfig and certificate files
KUBECONFIG_ORIGINAL="/home/nikos/.kube/config"
CERTIFICATE_AUTHORITY="/home/nikos/.minikube/ca.crt"
CLIENT_CERTIFICATE="/home/nikos/.minikube/profiles/minikube/client.crt"
CLIENT_KEY="/home/nikos/.minikube/profiles/minikube/client.key"

# Path to the new kubeconfig file
KUBECONFIG_MODIFIED="/home/nikos/.kube/config.backup"

# Copy original kubeconfig
cp "$KUBECONFIG_ORIGINAL" "$KUBECONFIG_MODIFIED"

# Encode the certificate and key files
CA_DATA=$(base64 < "$CERTIFICATE_AUTHORITY" | tr -d '\n')
CLIENT_CERT_DATA=$(base64 < "$CLIENT_CERTIFICATE" | tr -d '\n')
CLIENT_KEY_DATA=$(base64 < "$CLIENT_KEY" | tr -d '\n')

# Replace file paths with base64 encoded data in kubeconfig
sed -i "s|certificate-authority:.*|certificate-authority-data: $CA_DATA|" "$KUBECONFIG_MODIFIED"
sed -i "s|client-certificate:.*|client-certificate-data: $CLIENT_CERT_DATA|" "$KUBECONFIG_MODIFIED"
sed -i "s|client-key:.*|client-key-data: $CLIENT_KEY_DATA|" "$KUBECONFIG_MODIFIED"
