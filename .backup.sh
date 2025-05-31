#!/bin/bash

#today="$(date -Iminutes)"
today="$(date -I)"

# Synchronize development repositories/user data
printf "\n\n==========================================" | tee -a "$HOME/.backup_$today.log"
printf "\n\n Syncing development repos...\n\n" | tee -a "$HOME/.backup_$today.log"
printf "==========================================\n\n" | tee -a "$HOME/.backup_$today.log"

# Use -q for quiet logging
rsync -vlrAUt --progress /ffast/Documents/orgs/ /develop/repos/orgs/ #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress /develop/repos/ /ffast/repos/ #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress /develop/repos/ /develop2/repos/ #| tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress /develop/misc/ /ffast/misc/ #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress /develop/misc/ /develop2/misc/ #| tee -a "$HOME/.backup_$today.log"


# Synchronize across hard drives
printf "\n\n==========================================" | tee -a "$HOME/.backup_$today.log"
printf "\n\n Syncing hard drives...\n\n" | tee -a "$HOME/.backup_$today.log"
printf "==========================================\n\n" | tee -a "$HOME/.backup_$today.log"

printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\nRunning SUDO rsync of 'borg repo' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

echo "sudo rsync -vlrAUt --progress /ffast/borg_backup/ /disks/block1/borg_backup/" >&2
sudo rsync -vlrAUt --progress /ffast/borg_backup/ /disks/block1/borg_backup/ #| tee -a "$HOME/.backup_$today.log"

printf "\n\nRunning SUDO rsync of 'tarballs' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"


echo "sudo rsync -vlrAUt --progress /ffast/tarballs/ /disks/block1/tarballs/" >&2
sudo rsync -vlrAUt --progress /ffast/tarballs/ /disks/block1/tarballs/ #| tee -a "$HOME/.backup_$today.log"


printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\n\nRunning rsync of 'docs' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress /ffast/Documents/ /disks/block1/Documents/ # | tee -a "$HOME/.backup_$today.log"

printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\n\nRunning rsync of 'source_files' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress /ffast/source_files/ /disks/block1/source_files/ # | tee -a "$HOME/.backup_$today.log"

# Create a borg backup repository (monthly at 8pm), ISO8601
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Daily backup, ommitting borg backup...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log
#sudo borg create -x --progress /ffast/borg_backup::monthly_develop_backup_$today /develop/

