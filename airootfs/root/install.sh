#!/bin/bash

set -e

current_dir=$(dirname $0)

$current_dir/mount_encrypted_data_drive.sh
cp -r mount_point/git_repos/archconfig .

(
    cd archconfig;
    git pull --ff-only
    git stash pop;
)

$current_dir/archconfig/install_arch_linux.sh
