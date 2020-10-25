# create-fcos-iso-with-ssh-key
Quick and easy way to create a personalized iso file of Fedora CoreOS that contains your public SSH key.

## Introduction

The bash script _create-fcos-iso-with-ssh-key.sh_ will

1. Download an official iso file into a temporary directory (created with `mktemp -d`)
2. Embed your public SSH key on to the iso 
3. Print the filepath of the iso to stdout

## Requirements

__podman__ or __docker__

## Usage

```
$ bash ./create-fcos-iso-with-ssh-key.sh podman stable ~/.ssh/id_rsa.pub myuser
```

| argument nr | value |
| --          | --    |
| 1           | _podman_ or _docker_ |
| 2           | _stable_, _testing_ or _next_ |
| 3           | architecture (_x86_64_, ...) |
| 4           | path to your public SSH key |
| 5           | username (choose _core_ if you need sudo permissions) |


## Examples

Download the _stable_ release with the architecture *x86_64* and create the user _core_ and let the public SSH key ~/.ssh/id_rsa.pub
be able to log in over ssh to that account. The software _podman_ is the tool used to run the containers in the bash script.

```
$ bash ./create-fcos-iso-with-ssh-key.sh podman x86_64 stable ~/.ssh/id_rsa.pub core 2> /dev/null
/tmp/tmp.E6sy3HM3Ls/fedora-coreos-32.20201004.3.0-live.x86_64.iso
```

The same command once again, but this time without `2> /dev/null` so that progress information is shown.

```
$ bash ./create-fcos-iso-with-ssh-key.sh podman x86_64 stable ~/.ssh/id_rsa.pub core 2> /dev/null
Trying to pull quay.io/coreos/fcct:release...
Getting image source signatures
Copying blob sha256:34dbed599d79d8b71ec20eff9d57e57d37c74a576e2e2e9eb4c1aed8aad11ad7
Copying blob sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
Writing manifest to image destination
Storing signatures
Trying to pull quay.io/coreos/coreos-installer:release...
Getting image source signatures
Copying blob sha256:dc2be5cbf70d0fc92b67e0fc72813da304e922cd67e20d2ecf6d1f5ca79e38b6
Copying blob sha256:1b33617cbc3e97135769d6a9216e0c2d53c325ce519f8d54f8e60b2c240351e7
Copying blob sha256:4a6d7f80866db4acdc4139d978466d2367dc80b9df353dd05be478fffaf97ee8
Copying blob sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
Writing manifest to image destination
Storing signatures
Read disk 41.1 MiB/742.0 MiB (5%)
Read disk 79.5 MiB/742.0 MiB (10%)
Read disk 122.5 MiB/742.0 MiB (16%)
Read disk 164.6 MiB/742.0 MiB (22%)
Read disk 207.6 MiB/742.0 MiB (27%)
Read disk 245.9 MiB/742.0 MiB (33%)
Read disk 293.8 MiB/742.0 MiB (39%)
Read disk 337.1 MiB/742.0 MiB (45%)
Read disk 368.8 MiB/742.0 MiB (49%)
Read disk 397.8 MiB/742.0 MiB (53%)
Read disk 426.4 MiB/742.0 MiB (57%)
Read disk 460.8 MiB/742.0 MiB (62%)
Read disk 497.2 MiB/742.0 MiB (67%)
Read disk 532.4 MiB/742.0 MiB (71%)
Read disk 564.8 MiB/742.0 MiB (76%)
Read disk 598.4 MiB/742.0 MiB (80%)
Read disk 632.9 MiB/742.0 MiB (85%)
Read disk 663.1 MiB/742.0 MiB (89%)
Read disk 691.3 MiB/742.0 MiB (93%)
Read disk 714.9 MiB/742.0 MiB (96%)
Read disk 724.9 MiB/742.0 MiB (97%)
Read disk 742.0 MiB/742.0 MiB (100%)
gpg: Signature made Mon Oct 19 19:01:03 2020 UTC
gpg:                using RSA key 97A1AE57C3A2372CCA3A4ABA6C13026D12C944D0
gpg: Good signature from "Fedora (32) <fedora-32-primary@fedoraproject.org>" [ultimate]
Read disk 742.0 MiB/742.0 MiB (100%)
/tmp/tmp.5r26NLqbuF/fedora-coreos-32.20201004.3.0-live.x86_64.iso
```
### Create USB stick

After creating the iso file, write it to a USB stick. Some tutorials: [Windows](https://ubuntu.com/tutorials/create-a-usb-stick-on-windows#1-overview), [MacOS](https://ubuntu.com/tutorials/create-a-usb-stick-on-macos#1-overview), [Ubuntu](https://ubuntu.com/tutorials/create-a-usb-stick-on-ubuntu#1-overview).

### Boot up the USB stick and log in with SSH

Assuming _core_ is the username chosen before and _192.0.2.10_ is the IP address that Fedora CoreOS got from the DHCP server while booting up, you can log in with

```
$ ssh core@192.0.2.10
```






