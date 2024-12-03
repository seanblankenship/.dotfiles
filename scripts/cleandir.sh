#!/bin/zsh

deleted_count=0
kept_count=0

for file in $(find . -type f -name "._*"); do
  echo "Found file: $file"
  echo -n "Do you want to delete this file? (y/n): "
  read -r choice

  case "$choice" in
    [yY])
      rm "$file"
      echo "File deleted."
      ((deleted_count++))
      ;;
    [nN])
      echo "File kept."
      ((kept_count++))
      ;;
    *)
      echo "Invalid choice. File kept by default."
      ((kept_count++))
      ;;
  esac
done

echo
echo "Cleanup Summary:"
echo "Files deleted: $deleted_count"
echo "Files kept: $kept_count"
