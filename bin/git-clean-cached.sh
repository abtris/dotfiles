#!/bin/bash
 
cat .gitignore | egrep -v "^#|^$" | while read line; do
  if [ -n "$line" ]; then
    OLD_IFS=$IFS; IFS=""
    for ignored_file in $( git ls-files "$line" ); do
      git rm --cached "$ignored_file"
    done
    IFS=$OLD_IFS
  fi
done
 
