#!/bin/bash

set -e

password=

if [ -z "$password" ]
then
    read -e -p "Enter disk's password: " password
fi

mkdir -p mount_point
printf "$password" | cryptsetup open /dev/sda1 data_drive -
mount /dev/mapper/data_drive mount_point
