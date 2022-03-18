#!/usr/bin/env bash

set -e

umount mount_point
cryptsetup close data_drive
rmdir mount_point
