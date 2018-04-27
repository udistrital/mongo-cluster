#!/usr/bin/env bash

set -e -u

set -o  pipefail

if ! terraform fmt -check=true ; then
  echo run terraform fmt > /dev/stderr
  exit 1
fi

localstack="localstack/localstack:0.8.6"

fake_s3="$(docker run -d -it -e SERVICES=s3 --rm -p 4572 "${localstack}")"

export TF_DATA_DIR="$(mktemp -d)"

cleanup() {
  set +e
  docker kill "${fake_s3}"
  rm -rf "${TF_DATA_DIR}"
}

trap cleanup EXIT
trap cleanup INT

export AWS_DEFAULT_REGION=dummy
export AWS_ACCESS_KEY_ID=dummy
export AWS_SECRET_ACCESS_KEY=dummy
export AWS_S3_ENDPOINT="http://$(docker port "${fake_s3}" 4572 | sed 's|0\.0\.0\.0|127.0.0.1.xip.io|')/"

while ! aws --endpoint "${AWS_S3_ENDPOINT}" s3api list-buckets ; do
  sleep 1
done

aws --endpoint "${AWS_S3_ENDPOINT}" s3api create-bucket --bucket oas-terraform-tfstate

terraform init

terraform validate
