#!/bin/sh

if [ -z "$1" ]; then
  echo "build.sh usage:"
  echo ""
  echo 'Set any env variables (see script) and then e.g.:'
  echo ""
  echo './build.sh -t user/runpod:sd-v2-1-512 \'
  echo '  --build-arg MODEL_ID="stabilityai/stable-diffusion-2-1-base"'
else
  DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain \
    docker build \
    --build-arg http_proxy="$http_proxy" \
    --build-arg https_proxy="$https_proxy" \
    --build-arg HF_AUTH_TOKEN="$HF_AUTH_TOKEN" \
    --build-arg AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
    --build-arg AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
    --build-arg AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION" \
    --build-arg AWS_S3_ENDPOINT_URL="$AWS_S3_ENDPOINT_URL" \
    --build-arg AWS_S3_DEFAULT_BUCKET="$AWS_S3_DEFAULT_BUCKET" \
    "$@" .
fi
