#!/usr/bin/env bash

set -e

if ! [ -d "mount_point" ]
then
    password=

    if [ -z "$password" ]
    then
        read -e -p "Enter disk's password: " password
    fi

    mkdir -p mount_point
    printf "$password" | cryptsetup open /dev/sda1 data_drive -
    mount /dev/mapper/data_drive mount_point
fi

cp -r mount_point/git_repos/archconfig .

(
    cd archconfig;
    git stash pop;
)
