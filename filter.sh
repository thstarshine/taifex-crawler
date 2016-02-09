#!/bin/bash
# bash filter.sh [TYPE]

DATA_DIR="/app/taifex-crawler/data/"
FILES=$DATA_DIR"*.rpt"
OUTPUT_FILES=$DATA_DIR"*.txt"
if [ $1 ]
	then
		TARGET=","$1" "
else
	TARGET=",MTX "
fi

echo "Target: "$TARGET
for FILENAME in $FILES; do
	YEAR=`echo $FILENAME|sed 's/.*Daily_\([0-9]\{4\}\)_.*/\1/'`
	MONTH=`echo $FILENAME|sed 's/.*Daily_[0-9]\{4\}\_\([0-9]\{2\}\)_.*/\1/'`
	NEXT_YEAR=$YEAR
	NEXT_MONTH=$(( 10#$MONTH + 1 ))
	NEXT_MONTH="$(printf "%02d" $NEXT_MONTH)"
	if [ $NEXT_MONTH -eq "13" ]
		then
			NEXT_YEAR=$(( 10#$YEAR + 1 ))
			NEXT_MONTH="01"
	fi

	YM=","$YEAR$MONTH" "
	LINES_NUM=`egrep "$TARGET" $FILENAME | egrep "$YM" | wc -l`
	if (( LINES_NUM == 0 ))
		then
			YM=","$NEXT_YEAR$NEXT_MONTH" "
	fi
	LINES_NUM=`egrep "$TARGET" $FILENAME | egrep "$YM" | wc -l`
	LINES=`egrep "$TARGET" $FILENAME | egrep "$YM"`

	OUTPUT=$DATA_DIR$YEAR".txt"
	echo "File: "$FILENAME", Y/M: "$YM", Lines: "$LINES_NUM
	echo $LINES >> $OUTPUT
done

# replace \r
echo "Replacing \r..."
for FILENAME in $OUTPUT_FILES; do
	`sed -i 's/\r\s*/\r\n/g' $FILENAME`
done

