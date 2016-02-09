#!/bin/bash

DATE=$(date +"%Y_%m_%d")
DIR=/app/taifex-crawler/data
FILENAME=Daily_$DATE.zip

cd $DIR
wget https://www.taifex.com.tw/DailyDownload/$FILENAME

FILESIZE=$(stat -c %s "$DIR/$FILENAME")
if [ $FILESIZE -lt 5000 ]
  then
    rm $DIR/$FILENAME
fi

git add .
git commit -m "daily update"
git push

