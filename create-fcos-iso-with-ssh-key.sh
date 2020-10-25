#!/bin/bash

set -o errexit
set -o nounset

# Just some sanity checks regarding the arguments

if [ $# -ne 5 ]; then
    echo "Error: Wrong number of arguments. 5 arguments are required."
    exit 1
fi

if [  $1 != "podman" -a $1 != "docker" ]; then
    echo "Error: The first argument should be either podman or docker"
    exit 1
fi

if [  $2 != "x86_64" ]; then
    echo "Error: The second argument should be x86_64  (more architectures will come in the future)"
    exit 1
fi

if [  $3 != "stable" -a $3 != "testing" -a $3 != "next" ]; then
    echo "Error: The second argument should be stable, testing or next"
    exit 1
fi

if [ ! -r $4 ]; then
    echo "Error: The fourth argument does not contain the path that is readable"
    exit 1
fi

# OK, the arguments were fine

# If SELINUX is enabled let us label the files in the volume
volumeArg=$(selinuxenabled 2> /dev/null && echo :Z || true)
tmpdir=$(mktemp -d)

echo -n "variant: fcos
version: 1.1.0
passwd:
  users:
    - name: $5
      ssh_authorized_keys:
        - " > ${tmpdir}/file.fcct

cat $4 >> ${tmpdir}/file.fcct
$1 run --pull=always --rm -i quay.io/coreos/fcct:release --pretty --strict < ${tmpdir}/file.fcct > ${tmpdir}/file.ign
$1 run --pull=always --rm -v ${tmpdir}:/data${volumeArg} -w /data quay.io/coreos/coreos-installer:release download --architecture $2 --stream $3 -f iso > /dev/null
isofilename=$(cd ${tmpdir} && ls fedora-coreos-*.iso)
isofilepath=$(ls ${tmpdir}/fedora-coreos-*.iso)
$1 run --rm -i -v ${tmpdir}:/data${volumeArg} -w /data quay.io/coreos/coreos-installer:release iso ignition embed $isofilename < ${tmpdir}/file.ign
echo $isofilepath
