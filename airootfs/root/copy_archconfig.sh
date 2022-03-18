#!/usr/bin/env bash

set -e

current_dir=$(dirname $0)

if ! [ -d "mount_point" ]
then
    $current_dir/mount_encrypted_data_drive.sh
fi

cp -r mount_point/git_repos/archconfig .

(
    cd archconfig;
    git stash pop;
)
