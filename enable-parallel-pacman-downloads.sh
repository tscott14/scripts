#! /bin/bash

# Number of parallel download threads running concurrently.
DL_THREAD_COUNT=5

# The pacman.conf file. Typically /etc/pacman.conf. Change for testing purposes.
TARGET_FILE='.tmp/pacman.conf'

# Irrelevant tagline thats unique. This will have no effect on the
# 	final pacman.conf file assuming its quite unique. Will break
#	pacman.conf file if to generic.
DELETE_PHRASE_HOOK='DESPITE_ONLY_MAKING_UP_13_PERCENT_OF_THE_POPULATION'

# Create a backup of pacman.conf if it does not already exist.
[ -z "$TARGET_FILE.bak" ] && sudo /usr/bin/cp -i /etc/pacman.conf /etc/pacman.conf.bak

# Replace #ParallelDownloads = 'some number' with ParallelDownloads = 'some number'
sudo /usr/bin/sed -i "s/#ParallelDownloads/ParallelDownloads = $DL_THREAD_COUNT\n#$DELETE_PHRASE_HOOK/" $TARGET_FILE
sudo /usr/bin/sed -i "/$DELETE_PHRASE_HOOK/d" $TARGET_FILE

# Print out the pacman.conf file
/usr/bin/cat $TARGET_FILE
