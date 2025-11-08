#!/bin/sh
set -e

SERVER_NAME=""
CERTIFICATE=""
CERTIFICATE_KEY=""
DECOROUTINATOR_KOTLIN_COMPILER_URL=""

while [ $# -gt 0 ]; do
  case "$1" in
    --server-name)
      SERVER_NAME="$2"
      shift 2
      ;;
    --certificate)
      CERTIFICATE="$2"
      shift 2
      ;;
    --certificate-key)
      CERTIFICATE_KEY="$2"
      shift 2
      ;;
    --decoroutinator-kotlin-compiler-url)
      DECOROUTINATOR_KOTLIN_COMPILER_URL="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

echo "$CERTIFICATE" > server.cer
echo "$CERTIFICATE_KEY" > server.key
SERVER_NAME=$(./utils/get_server_name.sh "$SERVER_NAME" server.cer)

./utils/fill_placeholder.sh SERVER_NAME "$SERVER_NAME" nginx.conf
./utils/fill_placeholder.sh DECOROUTINATOR_KOTLIN_COMPILER_URL "$DECOROUTINATOR_KOTLIN_COMPILER_URL" nginx.conf

exec nginx -p / -e /dev/stderr -c nginx.conf
