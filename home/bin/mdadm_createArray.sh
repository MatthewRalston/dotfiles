#!/bin/bash
set -e



# Author: Matt Ralston
# Email: mralston.development@gmail.com
# Date: 1/22/23
#










echo >2
echo "Running mdadm command to generate a RAID5 array from 4 drives." >2
echo >2
echo 'sudo /sbin/mdadm --create --verbose /dev/md1 --name mini_RAID5 --level=5 --raid-devices=4 /dev/something1 /dev/something2 /dev/something3 /dev/something4' >2
sudo /sbin/mdadm --create --verbose /dev/md1 --name mini_RAID5 --level=5 --raid-devices=4 /dev/something1 /dev/something2 /dev/something3 /dev/something4


