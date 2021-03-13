#!/bin/bash
#
# backup DB


BACK_DIR=/data/.db_backup
DBUSER="dataupuser"
DBPWD="S123456"
DBHOST1="10.0.0.1"
DATABASES1=(db1 db2 db3)

source /etc/profile

for i in ${DATABASES1[@]};do

	if [ ! -d ${BACK_DIR} ];then
	    mkdir -p  ${BACK_DIR}
	fi
    mysqldump -u${DBUSER} -p${DBPWD}  -h${DBHOST1}  --hex-blob --single-transaction --default-character-set=utf8 --set-gtid-purged=OFF ${i} |gzip > ${BACK_DIR}/$(date +%F)_${i}.gz
    if [ $? != 0 ];then
        echo "$(date + %F-%T) ${i} backup error"  >> ${BACK_DIR}/bak.log;
    else
    	rm -f $BACK_DIR/$(date +%F -d '30 days ago')_${i}.gz
    fi
done