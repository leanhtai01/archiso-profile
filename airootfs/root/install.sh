#!/bin/bash

set -e

current_dir=$(dirname $0)
device="nvme0n1"
is_dual_boot="y"

$current_dir/connect_wifi_iwd.sh
$current_dir/mount_encrypted_data_drive.sh
cp -r mount_point/git_repos/archconfig .

(
    cd archconfig;
    git pull --ff-only
    git stash pop;
)

# check whether Windows partitions (1-4) is exists
for i in {1..4}
do
    partition="${device}p${i}"
    if ! [[ -b "$partition" ]]
    then
        is_dual_boot="n"
        break
    fi
done

if [[ "$is_dual_boot" -eq "y" ]]
then
    # dual-boot with Windows
    sed -i "/^size_of_ram=16/s/16/5/" $current_dir/archconfig/system_install/set_install_info.sh
    sed -i "/^user_choice=2/s/2/5/" $current_dir/archconfig/system_install/set_install_info.sh
else
    # only Arch Linux
    $current_dir/archconfig/install_arch_linux.sh
fi
