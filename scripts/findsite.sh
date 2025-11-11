#!/bin/bash

source "$(dirname "$0")/.env"

if [ "$#" -lt 1 ]; then
  echo "Usage: findsite <search1> [search2] [search3] ..."
  exit 1
fi

search_terms=("$@")

default_path="${DEFAULT_PATH:-/var/www/vhosts/}"

servers=()
for var in ${!SERVER_*}; do
  key="${var#SERVER_}"                
  server="${!var}"                    
  path_var="PATH_${key}"              
  path="${!path_var:-$default_path}"  
  servers+=("$key:$server:$path")
done

summary=()

normalize_domain() {
  local term="$1"

  term=$(printf '%s' "$term" | tr 'A-Z' 'a-z')

  term="${term#http://}"
  term="${term#https://}"

  term="${term%%/*}"

  term="${term%%:*}"

  printf '%s\n' "$term"
}

has_custom_rules() {
  local key="$1"

  local max_var="MAX_CHARS_${key}"
  local strip_var="STRIP_NONALNUM_${key}"
  local prefix_var="PREFIX_IF_DIGIT_${key}"

  if [ -n "${!max_var}" ] || [ -n "${!strip_var}" ] || [ -n "${!prefix_var}" ]; then
    return 0
  fi

  return 1
}

domain_to_dirname_for_server() {
  local key="$1"
  local domain="$2"

  local base="${domain%%.*}"

  local max_var="MAX_CHARS_${key}"
  local strip_var="STRIP_NONALNUM_${key}"
  local prefix_var="PREFIX_IF_DIGIT_${key}"

  local max="${!max_var:-16}"
  local strip="${!strip_var}"
  local prefix="${!prefix_var:-a}"

  local name="$base"

  if [ "$(printf '%s' "$strip" | tr 'A-Z' 'a-z')" = "true" ]; then
    name=$(printf '%s' "$name" | tr -cd '[:alnum:]')
  fi

  case "$name" in
    [0-9]*)
      name="${prefix}${name}"
      ;;
  esac

  name="${name:0:$max}"

  printf '%s\n' "$name"
}

for entry in "${servers[@]}"; do
  IFS=':' read -r key server path <<< "$entry"

  echo
  echo "Checking $server:$path for: ${search_terms[*]}"

  remote_list=$(ssh -o WarnWeakCrypto=no "$server" "ls -1d ${path}* 2>/dev/null" || true)

  if [ -z "$remote_list" ]; then
    echo -e "  \033[0;31mUnable to list directories or none found at $path on $server\033[0m"
    continue
  fi

  found_any=false

  for term in "${search_terms[@]}"; do
    norm=$(normalize_domain "$term")

    if has_custom_rules "$key"; then
      user=$(domain_to_dirname_for_server "$key" "$norm")
      [ -z "$user" ] && continue

      matches=$(printf '%s\n' "$remote_list" | grep -iE "/${user}\$" || true)
      search_label="${term} -> ${user}"
    else
      full="$norm"
      base="${norm%%.*}"

      if [ "$full" != "$base" ]; then
        pattern="$full|$base"
      else
        pattern="$full"
      fi

      if [ -z "$pattern" ]; then
        continue
      fi

      matches=$(printf '%s\n' "$remote_list" | grep -iE "$pattern" || true)
      search_label="$term"
    fi

    if [ -n "$matches" ]; then
      found_any=true
      echo -e "  \033[1;32mMatches for '$search_label':\033[0m"
      while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "    - $line"
        summary+=("$server  $line")
      done <<< "$matches"
    fi
  done

  if [ "$found_any" = false ]; then
    echo -e "  \033[0;31mNo matches for any term on $server\033[0m"
  fi
done

if [ "${#summary[@]}" -gt 0 ]; then
  echo
  echo "┌ MATCHES --------------------------------------------------------┐"
  printf '%s\n' "${summary[@]}" | sort -u | sed 's/^/│ /'
  echo "└-----------------------------------------------------------------┘"
else
  echo
  echo "No matches found on any server for: ${search_terms[*]}"
fi

