#!/bin/sh
set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <placeholder_name> <placeholder_value> <file>"
  exit 1
fi

PLACEHOLDER_NAME="$1"
VALUE="$2"
FILE="$3"
PLACEHOLDER_ESCAPER='\$\$'

awk \
-v placeholder="$PLACEHOLDER_ESCAPER$PLACEHOLDER_NAME$PLACEHOLDER_ESCAPER" \
-v value="$VALUE" \
'{
    gsub(placeholder, value)
    print
}' \
"$FILE" > "$FILE.tmp"
mv "$FILE.tmp" "$FILE"

echo "Successfully set [$FILE]'s placeholder [$PLACEHOLDER_NAME] with [$VALUE]."
