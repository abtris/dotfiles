#!/bin/bash

#
# Docker toolbox init OS X
#

FORCE=${1-true}

USERS="/Users"
VAR="/var/folders"
TMP="/tmp"
LOG_OSX="/private/var/log"
LOG_UNIX="/var/log"

if [ -d ${LOG_OSX} ]; then
  DIRS=("$USERS" "$VAR" "$TMP" "$LOG_OSX");
elif [ -d ${LOG_UNIX} ]; then
  DIRS=("$USERS" "$VAR" "$TMP" "$LOG_UNIX");
else
  DIRS=("$USERS" "$VAR" "$TMP");
fi

USERID="2004"
GROUPID="50"

VM=default
DOCKER_MACHINE=/usr/local/bin/docker-machine
VBOXMANAGE=/Applications/VirtualBox.app/Contents/MacOS/VBoxManage

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [ ! -f "${DOCKER_MACHINE}" ] || [ ! -f "${VBOXMANAGE}" ]; then
  echo "Either VirtualBox or Docker Machine are not installed. Please re-run the Toolbox Installer and try again."
  exit 1
fi

"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?

if [ $VM_EXISTS_CODE -eq 1 ]; then
  "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null
  rm -rf ~/.docker/machine/machines/"${VM}"
  "${DOCKER_MACHINE}" create -d virtualbox --virtualbox-memory 2048 --virtualbox-disk-size 144800 "${VM}"
  # "${DOCKER_MACHINE}" create -d virtualbox --virtualbox-memory 2048 --virtualbox-disk-size 204800 "${VM}"
fi

VM_STATUS="$(${DOCKER_MACHINE} status ${VM} 2>&1)"
if [ "${VM_STATUS}" != "Running" ]; then
  "${DOCKER_MACHINE}" start "${VM}"
  yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"
fi

eval "$(${DOCKER_MACHINE} env --shell=bash ${VM})"

function umount {
  DIR=$1
  WORKDIR=$2

  echo "$DIR mount deteted, unmounting now."
  $DOCKER_MACHINE ssh $VM "sudo umount $DIR"
  $VBOXMANAGE sharedfolder remove $VM --name "$WORKDIR" --transient
}

function mount {
  DIR=$1
  WORKDIR=$2

  $DOCKER_MACHINE ssh $VM "sudo mkdir -p $DIR"

  $VBOXMANAGE sharedfolder add $VM --name "$WORKDIR" --hostpath "$DIR" --transient
  $DOCKER_MACHINE ssh $VM "sudo mount -t vboxsf -o uid=$USERID,gid=$GROUPID $WORKDIR $DIR"
  $VBOXMANAGE setextradata $VM "VBoxInternal2/SharedFoldersEnableSymlinksCreate/$WORKDIR" 1

  echo "Mount $DIR created."
}

for DIR in "${DIRS[@]}"; do
  WORKDIR=$(basename "$DIR")

  MOUNT_EXISTS="$($DOCKER_MACHINE ssh $VM "mount | grep vboxsf | grep $DIR" 2>/dev/null)"

  if [ "$FORCE" == "true" ] && [ -n "$MOUNT_EXISTS" ]; then
    umount $DIR $WORKDIR
    mount $DIR $WORKDIR
  elif [ -z "$MOUNT_EXISTS" ]; then
    mount $DIR $WORKDIR
  else
    echo "$DIR already mounted"
  fi

done

# Symlink docker binaries for compatibility with other OSs locations
docker-machine ssh $VM "sudo ln -sf /usr/local/bin/docker /usr/bin/docker"
docker-machine ssh $VM "sudo ln -sf /usr/local/bin/docker /bin/docker"
docker-machine ssh $VM "sudo ln -sf /usr/local/bin/docker /usr/bin/codacy-docker"

# Use OverlayFS instead of AUFS
docker-machine ssh $VM sudo su -c \"sed -i '/DOCKER_STORAGE/c\DOCKER_STORAGE=overlay' /var/lib/boot2docker/profile\"
docker-machine ssh $VM sudo /etc/init.d/docker restart
