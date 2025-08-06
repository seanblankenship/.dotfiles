#!/bin/bash

set -a
source "$(dirname "$0")/.env"
set +a

domain="$1"
if [ -z "$domain" ]; then
  echo "Needs a search term: findsite <domain>"
  exit 1
fi

default_path="${DEFAULT_PATH:-/var/www/vhosts/}"

servers=()
for var in ${!SERVER_*}; do
  key="${var#SERVER_}"
  server="${!var}" 
  path_var="PATH_${key}"
  path="${!path_var:-$default_path}"
  servers+=("$server:$path")
done

for entry in "${servers[@]}"; do
  IFS=':' read -r server path <<< "$entry"
  echo "Checking $server:$path for folders containing '$domain'..."

  matches=$(ssh "$server" "ls -1d $path* 2>/dev/null | grep -i \"$domain\"" )

  if [ -n "$matches" ]; then
    echo -e "\033[1;32mFound on $server:\033[0m"
    echo "$matches" | sed 's/^/  - /'
  else
    echo -e "\033[0;31mNot found on $server\033[0m"
  fi
done