#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: No directories specified"
    echo "Usage: $0 directory1 [directory2] [directory3] ..."
    exit 1
fi

echo "."

for dir in "$@"; do
    dir="${dir%/}"
    
    if [ ! -d "$dir" ]; then
        echo "Warning: Directory '$dir' does not exist, skipping"
        continue
    fi
    
    echo "└── $dir/"
    
    file_count=0
    while IFS= read -r file; do
        file_count=$((file_count + 1))
        rel_path="${file#$dir/}"
        echo "    └── $rel_path"
    done < <(find "$dir" -type f -not -path "*/\.*" | sort)
    
    if [ $file_count -eq 0 ]; then
        echo "    └── (empty directory)"
    fi
done

exit 0
