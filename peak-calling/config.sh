set -ue

OLD_DIR='/home/ywang/retina/fastq/'

E17_K27_BASENAME='E17_H3K27me3'
PN15_K27_BASENAME='PN15_H3K27me3'
E17_K4_BASENAME='E17_H3K4me2'
PN15_K4_BASENAME='PN15_H3K4me2'

E17_K27_FASTQ_FILENAME="${E17_K27_BASENAME}_fastq_prefilter.fq"
PN15_K27_FASTQ_FILENAME="${PN15_K27_BASENAME}_fastq_prefilter.fq"
E17_K4_FASTQ_FILENAME="${E17_K4_BASENAME}_fastq_prefilter_1.3.fq"
PN15_K4_FASTQ_FILENAME="${PN15_K4_BASENAME}_fastq_prefilter_1.3.fq"

E17_K4_OLD_FILE='/home/ywang/retina/H3K4me2_zip/E17_fastq.txt'
PN15_K4_OLD_FILE='/home/ywang/retina/H3K4me2_zip/PN15_fastq.txt'

FASTQ_DIR="${PWD}/fastq/"

###########################################################################################
#echo 'Convert quality scores'
#python ./scripts/convert_quality.py $E17_K4_OLD_FILE "${OLD_DIR}/${E17_K4_FASTQ_FILENAME}"
#python ./scripts/convert_quality.py $PN15_K4_OLD_FILE "${OLD_DIR}/${PN15_K4_FASTQ_FILENAME}"

#echo 'Create a fastq folder'
#mkdir -p $FASTQ_DIR

#echo 'Copy all files to ${FASTQ_DIR}'
#FASTQ_FILENAME=$E17_K27_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
E17_K27_FASTQ_FILE="${FASTQ_DIR}${E17_K27_FASTQ_FILENAME}"
FASTQ_FILE=$E17_K27_FASTQ_FILENAME
OUTPUT_NAME="${FASTQ_FILE%.*}"
#python ./scripts/convert_bases.py $FASTQ_FILE "${OUTPUT_NAME}b.fq"
E17_K27_FASTQ_FILENAME="${OUTPUT_NAME}b.fq"

FASTQ_FILENAME=$PN15_K27_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR

FASTQ_FILENAME=$E17_K4_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR

FASTQ_FILENAME=$PN15_K4_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR

E17_K27_FASTQ_FILE="${FASTQ_DIR}${E17_K27_FASTQ_FILENAME}"
PN15_K27_FASTQ_FILE="${FASTQ_DIR}${PN15_K27_FASTQ_FILENAME}"
E17_K4_FASTQ_FILE="${FASTQ_DIR}${E17_K4_FASTQ_FILENAME}"
PN15_K4_FASTQ_FILE="${FASTQ_DIR}${PN15_K4_FASTQ_FILENAME}"

#trim_con, trim_var, discard
#QC_METHOD='trim_var'
SEQTK_CMD='/home/ywang/src/seqtk/seqtk'
FASTX_CMD='/home/export/tools/fastx/fastq_quality_filter'

MAX_BP=36
MIN_BP=30
((TRIM_BP=$MAX_BP-$MIN_BP))

#bash quality_control.sh $E17_K27_FASTQ_FILE trim_con $SEQTK_CMD $FASTX_CMD $TRIM_BP . "${FASTQ_DIR}${E17_K27_BASENAME}_fastq_trim${MIN_BP}.fq"
#p = 10 ^ (-q/10) if p = 25, q = 0.00316227766... 
#bash quality_control.sh $E17_K27_FASTQ_FILE discard $SEQTK_CMD $FASTX_CMD 25 50 "${FASTQ_DIR}${E17_K27_BASENAME}_fastq_q25p50.fq"
#bash quality_control.sh "${FASTQ_DIR}${E17_K27_BASENAME}_fastq_trim${MIN_BP}.fq" discard $SEQTK_CMD $FASTX_CMD 25 40 "${FASTQ_DIR}${E17_K27_BASENAME}_fastq_trim${MIN_BP}_q25p40.fq"

bash quality_control.sh $PN15_K27_FASTQ_FILE discard $SEQTK_CMD $FASTX_CMD 25 50 "${FASTQ_DIR}${PN15_K27_BASENAME}_fastq_q25p50.fq" 