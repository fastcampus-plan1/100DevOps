#!/bin/bash
SERVER=$(kubectl get nodes -o json | jq '.items[] | .status .addresses[] | select(.type=="ExternalIP") | .address' | tr -d '"')
for server in $SERVER
do
# 각자의 키 경로를 잘 확인해주세요.
  ssh -i ~/aws_rsa ec2-user@$server bash < 29.install_kubectl.sh
done
