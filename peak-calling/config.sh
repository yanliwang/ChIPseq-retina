set -ue

OLD_DIR='/home/ywang/retina/fastq/'
E17_K27_FASTQ_FILENAME='E17_H3K27me3_fastq_prefilter.fq'
PN15_K27_FASTQ_FILENAME='PN15_H3K27me3_fastq_prefilter.fq'
E17_K4_FASTQ_FILENAME='E17_H3K4me2_fastq_prefilter_1.3.fq'
PN15_K4_FASTQ_FILENAME='PN15_H3K4me2_fastq_prefilter_1.3.fq'

E17_K4_OLD_FILE='/home/ywang/retina/H3K4me2_zip/E17_fastq.txt'
PN15_K4_OLD_FILE='/home/ywang/retina/H3K4me2_zip/PN15_fastq.txt'

#echo 'Convert quality scores'
#python ./scripts/convert_quality.py $E17_K4_OLD_FILE "${OLD_DIR}/${E17_K4_FASTQ_FILENAME}"
#python ./scripts/convert_quality.py $PN15_K4_OLD_FILE "${OLD_DIR}/${PN15_K4_FASTQ_FILENAME}"

FASTQ_DIR="${PWD}/fastq/"
echo 'Create a fastq folder'
mkdir -p $FASTQ_DIR

#FASTQ_FILENAME=$E17_K27_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILENAME=$PN15_K27_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILENAME=$E17_K4_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILENAME=$PN15_K4_FASTQ_FILENAME
#cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR

FASTQ_FILE="${FASTQ_DIR}${E17_K27_FASTQ_FILENAME}"
OUTPUT_NAME="${FASTQ_FILE%.*}"
python ./scripts/convert_bases.py $FASTQ_FILE "${OUTPUT_NAME}b.fq"
E17_K27_FASTQ_FILENAME="${OUTPUT_NAME}b.fq"

FASTQ_FILENAME=$PN15_K27_FASTQ_FILENAME
cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILE="${FASTQ_DIR}/${FASTQ_FILENAME}"

FASTQ_FILENAME=$E17_K4_FASTQ_FILENAME
cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILE="${FASTQ_DIR}/${FASTQ_FILENAME}"

FASTQ_FILENAME=$PN15_K4_FASTQ_FILENAME
cp -u "${OLD_DIR}${FASTQ_FILENAME}" $FASTQ_DIR
#FASTQ_FILE="${FASTQ_DIR}/${FASTQ_FILENAME}"

#trim_con, trim_var, discard
#QC_METHOD='trim_var'
SEQTK_CMD='/home/ywang/src/seqtk/seqtk'
FASTX_CMD='/home/export/tools/fastx/fastq_quality_filter'

#bash quality_control.sh $FASTQ_FILE $QC_METHOD $SEQTK_CMD $FASTX_CMD 50