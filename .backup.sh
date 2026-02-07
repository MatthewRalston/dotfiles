#!/bin/bash

#today="$(date -Iminutes)"
today="$(date -I)"


# Misc files
DEV_MISC=
FAST_MISC=
DEV2_MISC=
# develop repositories
DEV_REPOS=
FAST_REPOS=
DEV2_REPOS=

# Documents
FAST_DOCS=
STORE_DOCS=
# Org files
FAST_ORGS=
DEV_ORGS=
# Borg
FAST_BORG=
STORE_BORG=

# Tarballs
#FAST_TAR=
STORE_TAR=

# SOurce files
#FAST_SOURCE=
STORE_SOURCE=


# Flat file sync

printf "\n\n==========================================" | tee =a $HOME/.backup_$today.log
printf "\n\n Creating a backup of Orgzly .org files from Dropbox...\n\n" | tee -a $HOME/.backup_$today.log
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
echo "rclone sync Dropbox:/orgzly ~/Documents/orgs/orgzly_backups/backups/${today}_orgzly_backup_from_Dropbox --progress" >> $HOME/.backup_$today.log
rclone sync Dropbox:/orgzly ~/Documents/orgs/orgzly_backups/backups/${today}_orgzly_backup_from_Dropbox --progress


# I n s t a l l e d   S y s t e m     P a c k a g e s

#  apt
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Creating list of manually installed apt packages...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log
echo "apt list --manual-installed > $DEV_MISC/ubuntu-system-packages/ubuntu-system-packages-$today.txt" >> $HOME/.backup_$today.log
apt list --manual-installed > $DEV_MISC/ubuntu-system-packages/ubuntu-system-packages-$today.txt


#    rust/cargo
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Creating list of manually installed rust/cargo packages...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log
echo "cargo install --list > $DEV_MISC/rust_crates/rust_crates_$today.txt" >> $HOME/.backup_$today.log
cargo install --list > $DEV_MISC/rust_crates/rust_crates_$today.txt


# Synchronize development repositories/user data
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Syncing development repos...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log


# Use -q for quiet logging

# Sync org files before backup from /ffast/Documents/orgs to /develop/repos/orgs
echo "rsync -vlrAUt --progress $FAST_ORGS $DEV_ORGS" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $FAST_ORGS/ $DEV_ORGS/ #| tee -a "$HOME/.backup_$today.log"
# Sync /develop/repos to /ffast/repos
echo "rsync -vlrAUt --progress $DEV_REPOS $FAST_REPOS" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $DEV_REPOS/ $FAST_REPOS/ #| tee -a "$HOME/.backup_$today.log"
# Sync repos from develop -> develop2
echo "rsync -vlrAUt --progress $DEV_REPOS $DEV2_REPOS" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $DEV_REPOS/ $DEV2_REPOS/ #| tee -a "$HOME/.backup_$today.log"

# Sync /develop/misc to /ffast/misc
echo "rsync -vlrAUt --progress $DEV_MISC $FAST_MISC" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $DEV_MISC/ $FAST_MISC/ #| tee -a "$HOME/.backup_$today.log"
# sync /develop/misc to /develop2/misc
echo "rsync -vlrAUt --progress $DEV_MISC $DEV2_MISC" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $DEV_MISC/ $DEV2_MISC/ #| tee -a "$HOME/.backup_$today.log"

# Synchronize across hard drives
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Syncing hard drives...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log

printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log
printf "\nRunning SUDO rsync of 'borg repo' across hard drives...\n" | tee -a $HOME/.backup_$today.log
printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log

echo "sudo rsync -vlrAUt --progress $FAST_BORG $STORE_BORG" >> $HOME/.backup_$today.log
sudo rsync -vlrAUt --progress $FAST_BORG/ $STORE_BORG/ #| tee -a "$HOME/.backup_$today.log"
# Disks block1 points to the 12TiB storage drive

#printf "\n\nRunning SUDO rsync of 'tarballs' across hard drives...\n" | tee -a $HOME/.backup_$today.log
#printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log


#echo "sudo rsync -vlrAUt --progress $FAST_TAR $STORE_TAR" >> $HOME/.backup_$today.log
#sudo rsync -vlrAUt --progress $FAST_TAR/ $STORE_TAR/ #| tee -a "$HOME/.backup_$today.log"


printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log
printf "\n\nRunning rsync of 'docs' across hard drives...\n" | tee -a $HOME/.backup_$today.log
printf "\n\n------------------" | tee -a $HOME/.backup_$today.log
echo "rsync -vlrAUt --progress $FAST_DOCS/ $STORE_DOCS/" >> $HOME/.backup_$today.log
rsync -vlrAUt --progress $FAST_DOCS/ $STORE_DOCS/ # | tee -a "$HOME/.backup_$today.log"

printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log
#printf "\n\nRunning rsync of 'source_files' across hard drives...\n" | tee -a $HOME/.backup_$today.log
#printf "\n\n------------------\n" | tee -a $HOME/.backup_$today.log

#echo "rsync -vlrAUt --progress $FAST_SOURCE/ $STORE_SOURCE/" >> $HOME/.backup_$today.log
#rsync -vlrAUt --progress $FAST_SOURCE/ $STORE_SOURCE/ # | tee -a "$HOME/.backup_$today.log"

# Create a borg backup repository (monthly at 8pm), ISO8601
printf "\n\n==========================================" | tee -a $HOME/.backup_$today.log
printf "\n\n Daily backup, ommitting borg backup...\n\n" | tee -a $HOME/.backup_$today.log
printf "==========================================\n\n" | tee -a $HOME/.backup_$today.log
echo "sudo borg create -x --progress $FAST_BORG::monthly_develop_backup_$today /develop/" >> $HOME/.backup_$today.log
echo "sudo borg create -x --progress $FAST_BORG::monthly_develop_backup_$today /develop/" >&2

#sudo borg create -x --progress $FAST_BORG::monthly_develop_backup_$today /develop/




