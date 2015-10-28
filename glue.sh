echo "How many signatures?"
read SIGS
echo "How many pages per signature?"
read PCOUNT
LINE="pdfjam "
for sig in `seq 1 $SIGS`;
do
  echo "Signature : $sig of $SIGS"
  i=$(($(($sig - 1)) * $PCOUNT))
  sig_file_name="output/temp_sig_$i.pdf"
  LINE="$LINE $sig_file_name"
done 
LINE="$LINE --outfile output/book.pdf"
echo $LINE
eval $LINE