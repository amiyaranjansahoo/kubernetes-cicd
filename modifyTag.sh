#!/bin/bash
sed "s/tagVersion/$1/g" pods.yaml > node-app-pod.yaml
