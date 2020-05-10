#!/bin/sh
#
# This script deploys the given manifest,
# tracks the deployment, and rolls back on failure.
#
# First execute this with "deployment-update.yaml" and then try it with "deployment-failed.yaml"
# example of execute: "autorollbackdep.shI deployment-failed.yaml"
#

MANIFEST_PATH=$1
DEPLOYMENT_NAME=tomcat-deployment

if [ -n "$2" ]; then
    DEPLOYMENT_NAME=$2
fi

kubectl apply -f "$MANIFEST_PATH"
if ! kubectl rollout status deployment "$DEPLOYMENT_NAME"; then
    echo "Rolling back deployment!" >&2
    kubectl rollout undo deployment "$DEPLOYMENT_NAME"
    kubectl rollout status deployment "$DEPLOYMENT_NAME"
    exit 1
fi
