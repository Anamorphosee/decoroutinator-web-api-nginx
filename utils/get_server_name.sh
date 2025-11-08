#!/bin/sh
set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <server_name> <certificate_file>"
  exit 1
fi

SERVER_NAME="$1"
CERT_FILE="$2"

if [ -z "$SERVER_NAME" ]; then
    if [ ! -f "$CERT_FILE" ]; then
        echo "Certificate file '$CERT_FILE' not found."
        exit 1
    fi
    openssl x509 -in "$CERT_FILE" -noout -subject | sed -n '/CN=/s/.*CN=\([^\/]*\).*/\1/p'
else
    echo "$SERVER_NAME"
fi
