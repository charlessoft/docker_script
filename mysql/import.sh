#!/bin/bash
source ./config.sh

if [ $# != 1 ]
then
    echo "eg: sh import.sh xx/bak_xx.sql"
fi
fullfile=$1
fullname="${fullfile##*/}"
dir="${fullfile%/*}"
extension="${fullname##*.}"
filename="${fullname%.*}"
# echo $dir , $fullname , $filename , $extension

docker cp ${fullfile} ${CONTAINER_NAME}:/tmp/
EXPORT_COMMAND="mysql -uroot -p${ROOT_PASSWORD} < /tmp/${fullname}"
echo $EXPORT_COMMAND
docker exec -it ${CONTAINER_NAME} /bin/bash -c "${EXPORT_COMMAND}"
