#!/bin/sh
set -e

docker build . --tag decoroutinator-web-api-nginx:$(date +%s)
