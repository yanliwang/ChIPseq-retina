
set -ue

#Quality Control

FASTQ_FILE=$1
#trim_con, trim_var, discard
QC_METHOD=$2 

SEQTK_CMD=$3
FASTX_CMD=$4
PARAM1=$5
PARAM2=$6
OUTPUT_FILE=$7

MAX_BP=36
MIN_BP=30
((TRIM_BP=$MAX_BP-$MIN_BP))

echo "$FASTQ_FILE $QC_METHOD $PARAM1 $PARAM2"

#Trim the reads to a constant length
if [ "$QC_METHOD" = "trim_con" ]
then
    $SEQTK_CMD trimfq -e $PARAM1 $FASTQ_FILE > $OUTPUT_FILE


#Trim the reads based on quality
elif [ "$QC_METHOD" = "trim_var" ]
then
    #p = 10 ^ (-q/10) if p = 25, q = 0.00316227766...
    $SEQTK_CMD trimfq -q $PARAM1 -l $PARAM2 $FASTQ_FILE > $OUTPUT_FILE


#Discard the reads based on quality
else
    $FASTX_CMD -q $PARAM1 -p $PARAM2 -i $FASTQ_FILE -o $OUTPUT_FILE
fi