#!/usr/bin/env bash

set -e -u

if ! terraform fmt -check=true ; then
  echo run terraform fmt > /dev/stderr
  exit 1
fi

localstack="localstack/localstack:0.8.6"

fake_s3_container="$(docker run -d -it -e SERVICES=s3 --rm -p 4572 "${localstack}")"

export TF_DATA_DIR="$(mktemp -d)"

cleanup() {
  set +e
  docker kill "${fake_s3_container}"
  rm -rf "${TF_DATA_DIR}"
}

trap cleanup EXIT
trap cleanup INT

fake_s3="$(docker port "${fake_s3_container}" 4572)"

export AWS_DEFAULT_REGION=dummy
export AWS_ACCESS_KEY_ID=dummy
export AWS_SECRET_ACCESS_KEY=dummy
export AWS_S3_ENDPOINT="http://${fake_s3//0.0.0.0/127.0.0.1.xip.io}/"

while ! aws --endpoint "${AWS_S3_ENDPOINT}" --cli-read-timeout 2 --cli-connect-timeout 2 s3api list-buckets ; do
  sleep 1
done

aws --endpoint "${AWS_S3_ENDPOINT}" s3api create-bucket --bucket oas-terraform-tfstate

terraform init

terraform validate
