#!/bin/sh
# REQUIRES PV (http://manpages.ubuntu.com/manpages/bionic/man1/pv.1.html)

echo 'STARTING BACKUP PROCEDURE'
echo '-------------------------'
echo

echo '[COMPRESSING FILES]'
tar -cf - --exclude=/backup.tar.gz --exclude=/tmp  --exclude=/dev  --exclude=/boot --exclude=/proc --exclude=/run --one-file-system / 2>/dev/null | pv | gzip > /backup.tar.gz
# TO EXCLUDE FILES OR FOLDERS - ADD MORE `--exclude=PATH` ATTRIBUTES
echo

echo '[UPLOADING BACKUP TO THE CLOUD]'
_date=$(date +"%d%m%Y_%H%M%S")
_filename="backup_$_date.tar.gz"
_user="user@server.tld"
scp -i ~/.ssh/id_rsa -P 23 /backup.tar.gz $_user:$_filename
echo

echo '[REMOVING TEMPORARY FILES]'
rm /backup.tar.gz

echo
echo '-------------------------'
echo 'A  L  L  I  S  D  O  N  E'