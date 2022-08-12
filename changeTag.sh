#!/bin/bash
sed "s/tagVersion/$1/g" pods.yaml > node-app-pod.yaml


 sed 's/v1/v2/' pods.yaml > node-app-pod.yaml