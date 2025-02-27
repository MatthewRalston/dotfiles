#!/bin/bash

#today="$(date -Iminutes)"
today="$(date -I)"

# Synchronize development repositories/user data
printf "\n\n==========================================" 2> $HOME/.backup_$today.log
printf "\n\n Syncing development repos...\n\n" 2> $HOME/.backup_$today.log
printf "==========================================\n\n" 2> $HOME/.backup_$today.log

rsync -qvlrAUt --progress /ffast/Documents/orgs/ /develop/repos/orgs/ 2> $HOME/.backup_$today.log
rsync -qvlrAUt --progress /develop/repos/ /ffast/repos/ 2> $HOME/.backup_$today.log


# Synchronize across hard drives
printf "\n\n==========================================" 2> $HOME/.backup_$today.log
printf "\n\n Syncing hard drives...\n\n" 2> $HOME/.backup_$today.log
printf "==========================================\n\n" 2> $HOME/.backup_$today.log

rsync -qvlrAUt --progress /develop/repos/ /ffast/repos/ 2> $HOME/.backup_$today.log
rsync -qvlrAUt --progress /develop/repos/  /storage/repos/ 2> $HOME/.backup_$today.log

# Create a borg backup repository (monthly at 8pm), ISO8601
printf "\n\n==========================================" 2> $HOME/.backup_$today.log
printf "\n\n Daily backup, ommitting borg backup...\n\n" 2> $HOME/.backup_$today.log
printf "==========================================\n\n" 2> $HOME/.backup_$today.log
#sudo borg create /ffast/borg_backup::monthly_develop_backup_$today

