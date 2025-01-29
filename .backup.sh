#!/bin/bash

# ==========================
#
#    W a r n i n g
#
# -----------------
#
# This is distributed with the GPLv2 license
#
# The author Matt Ralston assumes no liability for said 'backup script'.
#
# This was written in 2025, I'm a wet lab scientist turned coder,
# I've got some core competencies in Linux, but I assume this script
# and others like it should be used in non-professional capacities.
#
# 
# ==========================



today="$(date -Iminutes)"


# Synchronize development repositories/user data


# ------
# Rsync command
# ------

cmd1="rsync -vlrAUt /ffast/Documents/orgs/ /develop/repos/orgs/ >> cross_drive_backup_log.${today}.log 2>&1"
cmd2="rsync -vlrAUt /develop/repos/ /ffast/repos/ >> cross_drive_backup_log.${today}.log 2>&1"
# Logging the rsync command
#
#
backup_log_file="cross_drive_backup_log.${today}.log"


echo "=========================================\n\n\n" >> $backup_log_file 2>&1
echo "\n\n\n       - - - - - - - - \n\n\n"  >> $backup_log_file 2>&1
echo $cmd1  >> $backup_log_file 2>&1
echo $cmd2  >> $backup_log_file 2>&1
echo " .... ran at $today" >> $backup_log_file 2>&1
echo "\n\n\n       - - - - - - - - \n\n\n"  >> cross_drive_backup_log.${today}.log 2>&1
echo "=========================================\n\n\n"  >> cross_drive_backup_log.${today}.log 2>&1
rsync -vlrAUt /ffast/Documents/orgs/ /develop/repos/orgs/ >> cross_drive_backup_log.${today}.log 2>&1


eval $cmd1 >> $backup_log_file 2>&1
eval $cmd2 >> $backup_log_file 2>&1



# Create a borg backup repository (monthly at 8pm), ISO8601

borg="sudo borg create /ffast/borg_backup::monthly_develop_backup_${today}"


echo $borg >> $backup_log_file 2>&1
eval $borg >> $backup_log_file 2>&1


