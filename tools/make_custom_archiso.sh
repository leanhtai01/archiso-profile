#!/bin/bash

set -e

current_dir=$(dirname $0)

cp -r /run/media/leanhtai01/data_drive/git_repos/archiso_profile $current_dir

(cd $current_dir/archiso_profile; git stash pop)

(cd $current_dir/archiso_profile/airootfs/root/archconfig; git stash pop)

sudo mkarchiso -v archiso_profile

