
set -ue

#Quality Control

FASTQ_FILE=$1
#trim_con, trim_var, discard
QC_METHOD=$2 

SEQTK_CMD=$3
FASTX_CMD=$4
READ_PER=$5

MAX_BP=36
MIN_BP=30
((TRIM_BP=$MAX_BP-$MIN_BP))


OUTPUT_NAME="${FASTQ_FILE%.*}"

#Trim the reads to a constant length
if [ "$QC_METHOD" = "trim_con" ]
then
    echo 'trim_con'
    $SEQTK_CMD trimfq -e $TRIM_BP $FASTQ_FILE > "${OUTPUT_NAME}_trim${MIN_BP}.fq"


#Trim the reads based on quality
elif [ "$QC_METHOD" = "trim_var" ]
then
    echo 'trim_var'
    #p = 10 ^ (-q/10) if p = 25, q = 0.00316227766...
    $SEQTK_CMD trimfq -q 0.0032 -l $MIN_BP $FASTQ_FILE > "${OUTPUT_NAME}_q0.0032_l${MIN_BP}.fq"


#Discard the reads based on quality
else
    echo 'discard'
    $FASTX_CMD -q 25 -p $READ_PER -i $FASTQ_FILE -o "${OUTPUT_NAME}_q25_p${READ_PER}.fq"
fi