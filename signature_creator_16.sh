#!/bin/bash
clear


echo "PDF file name:"
read FILE_NAME
echo "PDF page count:"
read PAGE_COUNT
echo "... looking at the following file:"
ls -la $FILE_NAME
echo

SIGS=$(($PAGE_COUNT / 16))
REMAINDER=$(($PAGE_COUNT % 16))
BLANKS=$((16-$REMAINDER))

echo "Checking..."
if [ "$REMAINDER" -gt 0 ]
  then
    echo "You will have $BLANKS blank page(s) at the end"
    SIGS=$(($SIGS + 1))
fi

echo "There will be $SIGS signatures"


if [ -d 'output' ]
  then
    rm -rf output
    echo "Dumping all old content from the directory 'output'"
fi

mkdir 'output'
TEMP_FILE_NAME="output/temp.pdf"
FLIPPED_FILE_NAME="output/temp_flipped.pdf"

cp $FILE_NAME $TEMP_FILE_NAME
pdf180 $FILE_NAME --outfile $FLIPPED_FILE_NAME

for sig in `seq 1 $SIGS`;
do
  echo "Signature : $sig of $SIGS"
  i=$(($(($sig - 1)) * 16))
  sig_file_name="output/temp_sig_$i.pdf"
  temp_cmd="pdfjam --nup 2x2 $FLIPPED_FILE_NAME '$(($i+1)),$(($i+16))' $TEMP_FILE_NAME '$(($i+4)),$(($i+13))' $FLIPPED_FILE_NAME '$(($i+15)),$(($i+2))' $TEMP_FILE_NAME '$(($i+14)),$(($i+3))' $FLIPPED_FILE_NAME '$(($i+5)),$(($i+12))' $TEMP_FILE_NAME '$(($i+8)),$(($i+9))' $FLIPPED_FILE_NAME '$(($i+11)),$(($i+6))' $TEMP_FILE_NAME '$(($i+10)),$(($i+7))'    --outfile $sig_file_name"
  echo $temp_cmd
  eval $temp_cmd
done 

exit 0
TEMP_CMD="ls"
echo
echo "what? '$TEMP_CMD'"
eval $TEMP_CMD
echo "done"
