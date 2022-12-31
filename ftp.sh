#!/bin/bash
 
############### INFO AKUN ########################
 
DATE=`date +%Y-%m-%d_%H%M`
LOCAL_BACKUP_DIR="/home/admin_jdih/backup/"
DB_NAME=""
 
FTP_SERVER=""
FTP_USERNAME=""
FTP_PASSWORD=""
FTP_UPLOAD_DIR=""
 
LOG_FILE=/home/admin_jdih/backup/
 
############### LOKAL BACKUP ########################
 
#tar fczP $LOCAL_BACKUP_DIR/website-$DATE-$DB_NAME.tar -C /home/admin_jdih/backup/
tar -C / -czvf  $LOCAL_BACKUP_DIR/$DATE-$DB_NAME.tar.gz /home/admin_jdih/backup/
 
############### UPLOAD KE FTP QNAP ################
 
ftp -nv $FTP_SERVER << EndFTP
user "$FTP_USERNAME" "$FTP_PASSWORD"
binary
cd $FTP_UPLOAD_DIR
lcd $LOCAL_BACKUP_DIR
put "$DATE-$DB_NAME.tar.gz"
bye
EndFTP
 
############### Check and save log  ################
 
if test $? = 0
then
    echo "SUKSES"
else
    echo "UPLOAD BACKUP DATABASE GAGAL" > $LOG_FILE
fi
 
find  $LOCAL_BACKUP_DIR/$DATE-$DB_NAME.* -mtime +3 -exec rm {} \;