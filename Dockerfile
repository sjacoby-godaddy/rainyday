FROM 764525110978.dkr.ecr.us-west-2.amazonaws.com/alpine-tartufo:v2.4.0

WORKDIR /tartufo

COPY entrypoint.py /entrypoint.py

ENTRYPOINT ["/entrypoint.py"]
