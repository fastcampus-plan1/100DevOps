#!/bin/bash
SERVER=$(kubectl get nodes -o json | jq '.items[] | .status .addresses[] | select(.type=="ExternalIP") | .address' | tr -d '"')
for server in $SERVER
do
  scp -i ~/aws_rsa file.txt ec2-user@$server:/tmp/
  #cloudshell 상에 있는 각자의 비밀키 경로를 잘 넣어주세요
done
