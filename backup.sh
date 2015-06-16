#!/bin/bash
#
# dump_all_dbs.sh
#     dump all mysql databases
#
# usage example:
#     host origem:
#     $ ./backup.sh 
#

#Set env variables 
MYSQL_TCP_PORT=3306
export MYSQL_TCP_PORT
PATH=${PATH}:/usr/local/mysql/bin
 
USER="root"
PASSWORD="root"
OUTPUT="/usr/local/backup"
 
rm "$OUTPUT/*gz" > /dev/null 2>&1
 
databases=`mysql --user=$USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --force --opt --user=$USER --password=$PASSWORD --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql
        gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done


