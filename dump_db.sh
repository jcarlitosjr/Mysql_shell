#!/bin/bash
#
# dump_db.sh
#     dump a mysql database
#
# usage example:
#     host origem:
#     $ ./dump_db.sh <dbname>
#

#Set env variables 
MYSQL_TCP_PORT=3306
export MYSQL_TCP_PORT
PATH=${PATH}:/usr/local/mysql/bin


mysql_dump() {
    mysqldump -u $DBUSER -p${DBPASS}    \
        $1 > ${DUMP}
}


[ -z "$1" ] && {

    echo
    echo "Usage: $0 dbname"
    echo
    exit 1

}

DBUSER=root
DBPASS=root
  HOST=$( hostname )
  HOST=${HOST%%.*}
    DT=$( /bin/date "+%Y-%m-%d-%H%M")
  DUMP="${HOST}_${1}_${DT}.dump.sql"

if mysql_dump $1
then gzip -v  $DUMP
fi
