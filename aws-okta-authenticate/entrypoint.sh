#!/bin/sh -l
export AWS_OKTA_USER=$1
export AWS_OKTA_PASS=$2
export AWS_OKTA_ORGANIZATION=$3
export AWS_OKTA_APPLICATION=$4
export AWS_OKTA_ROLE=$5
export AWS_REGION=$6
###### Remove below line before committing #######
export GITHUB_ENV=$7
###### Remove above line before committing #######
export AWS_OKTA_DURATION=7200
export AWS_OKTA_KEY=$(openssl rand -hex 18)
export AWS_OKTA_FACTOR="push:okta"

aws-okta-processor authenticate -e
echo $?
eval $(aws-okta-processor authenticate -e --silent)
#eval 'aws-okta-processor authenticate -e --silent'
echo $?

# Add mask to prevent logging these credentials
echo ::add-mask::"${AWS_ACCESS_KEY_ID}"
echo ::add-mask::"${AWS_SECRET_ACCESS_KEY}"
echo ::add-mask::"${AWS_SESSION_TOKEN}"

# Set the credentials on the environment for downstream GitHub Actions
echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" >> $GITHUB_ENV
echo $?
echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" >> $GITHUB_ENV
echo $?
echo "AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}" >> $GITHUB_ENV
echo $?
echo "AWS_DEFAULT_REGION=${AWS_REGION}" >> $GITHUB_ENV
echo $?
echo "AWS_REGION=${AWS_REGION}" >> $GITHUB_ENV
echo $?
