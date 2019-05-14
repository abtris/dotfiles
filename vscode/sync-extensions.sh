#!/bin/sh

DIRNAME=$(dirname $0)

DESIRED=($(cat "$DIRNAME/extensions.list"))
INSTALLED=($(code --list-extensions))

TOREMOVE=("${INSTALLED[@]}")
for i in "${DESIRED[@]}"; do
  TOREMOVE=(${TOREMOVE[@]//*$i*})
done

TOINSTALL=("${DESIRED[@]}")
for i in "${INSTALLED[@]}"; do
  TOINSTALL=(${TOINSTALL[@]//*$i*})
done

# Uninstall extensions which are not listed
for ext in "${TOREMOVE[@]}"; do
  code --uninstall-extension $ext
done

# Install extensions
for ext in "${TOINSTALL[@]}"; do
  code --install-extension $ext
done

