#!/bin/bash

#today="$(date -Iminutes)"
today="$(date -I)"

MISC=
DEV_REPOS=
FAST_REPOS=
DEV2_REPOS=
FAST_ORGS=
DEV_ORGS=
FAST_MISC=
FAST_BORG=
STORE_BORG=
FAST_DOCS=
STORE_DOCS=
FAST_TAR=
STORE_TAR=
FAST_SOURCE=
STORE_SOURCE=


printf "\n\n==========================================" | tee -a "$HOME/.backup_$today.log"
printf "\n\n Creating list of manually installed apt packages...\n\n" | tee -a "$HOME/.backup_$today.log"
printf "==========================================\n\n" | tee -a "$HOME/.backup_$today.log"
apt list --manual-installed > $MISC/ubuntu-system-packages-$today.txt


# Synchronize development repositories/user data
printf "\n\n==========================================" | tee -a "$HOME/.backup_$today.log"
printf "\n\n Syncing development repos...\n\n" | tee -a "$HOME/.backup_$today.log"
printf "==========================================\n\n" | tee -a "$HOME/.backup_$today.log"

# Use -q for quiet logging
rsync -vlrAUt --progress $FAST_ORGS $DEV_ORGS #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress $DEV_REPOS $FAST_REPOS #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress $DEV_REPOS $DEV2_REPOS #| tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress $DEV_MISC $FAST_MISC #| tee -a "$HOME/.backup_$today.log"
rsync -vlrAUt --progress $DEV_MISC $DEV2_MISC #| tee -a "$HOME/.backup_$today.log"


# Synchronize across hard drives
printf "\n\n==========================================" | tee -a "$HOME/.backup_$today.log"
printf "\n\n Syncing hard drives...\n\n" | tee -a "$HOME/.backup_$today.log"
printf "==========================================\n\n" | tee -a "$HOME/.backup_$today.log"

printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\nRunning SUDO rsync of 'borg repo' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

echo "sudo rsync -vlrAUt --progress $FAST_BORG $STORE_BORG" >&2
sudo rsync -vlrAUt --progress $FAST_BORG $STORE_BORG #| tee -a "$HOME/.backup_$today.log"
# Disks block1 points to the 12TiB storage drive

printf "\n\nRunning SUDO rsync of 'tarballs' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"


echo "sudo rsync -vlrAUt --progress $FAST_TAR $STORE_TAR" >&2
sudo rsync -vlrAUt --progress $FAST_TAR $STORE_TAR #| tee -a "$HOME/.backup_$today.log"


printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\n\nRunning rsync of 'docs' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress $FAST_DOCS $STORE_DOCS # | tee -a "$HOME/.backup_$today.log"

printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"
printf "\n\nRunning rsync of 'source_files' across hard drives...\n" | tee -a "$HOME/.backup_$today.log"
printf "\n\n------------------" | tee -a "$HOME/.backup_$today.log"

rsync -vlrAUt --progress $FAST_SOURCE $STORE_SOURCE # | tee -a "$HOME/.backup_$today.log"

# Create a borg backup repository (monthly at 8pm), ISO8601
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Daily backup, ommitting borg backup...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log
#sudo borg create -x --progress $FAST_BORG::monthly_develop_backup_$today /develop/

