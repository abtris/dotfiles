for name in */ ; do
  if [ -d "$name" ] && [ ! -L "$name" ]; then
    cd $name
    if [ -d ".git" ]; then
      BRANCH=`git branch --no-color | grep -e "^*" | tr -d ' *'`      
      if [ "$BRANCH" == "master" ] || [ "$BRANCH" == "main" ]; then
        if git remote | grep origin > /dev/null; then
          printf 'Update source in directory: %s\n' "$name"        
          git pull
        fi
      fi
    fi
    cd ..
  fi 
done
