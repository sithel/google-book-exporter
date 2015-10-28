#!/bin/bash
clear

p1=44;if [ "$i" -gt 10 ];then p1="[]";fi

echo "PDF file name:"
read FILE_NAME
echo "PDF page count:"
read PAGE_COUNT
echo "... looking at the following file:"
ls -la $FILE_NAME
echo

SIGS=$(($PAGE_COUNT / 32))
REMAINDER=$(($PAGE_COUNT % 32))
BLANKS=$((32-$REMAINDER))

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
  i=$(($(($sig - 1)) * 32))
  #p1=44;if [ "$i" -gt 10 ];then p1="[]";fi
  sig_file_name="output/temp_sig_$i.pdf"
  p1=$(($i+1))
  temp_cmd="pdfjam --nup 2x2 $FLIPPED_FILE_NAME '$(($i+1)),$(($i+32))' $TEMP_FILE_NAME '$(($i+4)),$(($i+29))' $FLIPPED_FILE_NAME '$(($i+31)),$(($i+2))' $TEMP_FILE_NAME '$(($i+30)),$(($i+3))' $FLIPPED_FILE_NAME '$(($i+5)),$(($i+28))' $TEMP_FILE_NAME '$(($i+8)),$(($i+25))' $FLIPPED_FILE_NAME '$(($i+27)),$(($i+6))' $TEMP_FILE_NAME '$(($i+26)),$(($i+7))'     $FLIPPED_FILE_NAME '$(($i+9)),$(($i+24))' $TEMP_FILE_NAME '$(($i+12)),$(($i+21))' $FLIPPED_FILE_NAME '$(($i+23)),$(($i+10))' $TEMP_FILE_NAME '$(($i+22)),$(($i+11))' $FLIPPED_FILE_NAME '$(($i+13)),$(($i+20))' $TEMP_FILE_NAME '$(($i+16)),$(($i+17))' $FLIPPED_FILE_NAME '$(($i+19)),$(($i+14))' $TEMP_FILE_NAME '$(($i+18)),$(($i+15))'   --outfile $sig_file_name"
  echo $temp_cmd
  eval $temp_cmd
done 

exit 0
TEMP_CMD="ls"
echo
echo "what? '$TEMP_CMD'"
eval $TEMP_CMD
echo "done"
