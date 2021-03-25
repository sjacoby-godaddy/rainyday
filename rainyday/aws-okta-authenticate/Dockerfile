FROM python:3.7.4-alpine

RUN apk upgrade --no-cache && apk add --no-cache jq openssl

RUN pip install --upgrade pip
RUN pip install aws-okta-processor

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
