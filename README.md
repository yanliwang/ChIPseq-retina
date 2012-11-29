ChIPseq-retina
=============
Week of 11/26/2012

/export/tools/bedtools

/export/src/ChIPseeqer-2.0
#Split files into separate chromosomes
/export/src/ChIPseeqer-2.0/dist/ChIPseeqerSplitReadFiles --format=sam --files="*.sam"
#Peak Calling
/export/src/ChIPseeqer-2.0/dist/ChIPseeqer.bin -chipdir . -outfile E17_H3K27me3_q25p50.txt -chrdata /export/src/ChIPseeqer-2.0/data/mm9.chrdata -format sam


							wc -l *.bedGraph.v2.txt		wc -l [reads].fq
E17	H3K27me3
Q25P50		7,387,821		4,362,442				29,551,284
8096 peaks detected in total
20.0 Average peak height (reads)
475.0 Average peak size (bp)
Used 4,695,971 ChIP reads

Trim30		11,481,938								45,927,752
8679 peaks detected in total
21.0 Average peak height (reads)
541.0 Average peak size (bp)
Used 5,355,878 ChIP reads

Trim30 Q25P40	8,168,382							32,673,528
8352 peaks detected in total
20.0 Average peak height (reads)
504.0 Average peak size (bp)
Used 4,973,661 ChIP reads

E17	H3K4me2	6,604,999	3,609,377				26,419,996
9154 peaks detected in total
17.0 Average peak height (reads)
214.0 Average peak size (bp)
Used 4,673,934 ChIP reads

PN15 H3K27me3	9,444,676	5,500,682				37,778,704
2861 peaks detected in total
19.0 Average peak height (reads)
218.0 Average peak size (bp)
Used 6,509,132 ChIP reads

PN15 H3K4me2	5,081,302	1,853,760				20,325,208
2349 peaks detected in total
13.0 Average peak height (reads)
169.0 Average peak size (bp)
Used 2,102,844 ChIP reads

find / -name 'fastqc' 2>/dev/null




Week of 11/19/2012
Filtering by mean quality:
~/src/bioawk/hawk -c fastx 'meanqual($seq) > n {print $seq}' E17_H3K27me3_fastq_prefilter.fq | wc -l
n:
25		11430965
30		11422360
35		11319022
36		10966728	~95%
37		9795094		~85%
40		2828142

~/src/bioawk/hawk -c fastx 'meanqual($seq) > 36 {printf("@%s\n%s\n+\n%s\n", $name, $seq, $qual)}' E17_H3K27me3_fastq_prefilter.fq > E17_H3K27me3_fastq_mq36.fq

/export/tools/FastQC/fastqc E17_H3K27me3_fastq_mq36.fq

find / -name 'fastqc' 2>/dev/null
/home/export/tools/fastx/





Week of 11/12/12
Seqtk
/home/export/tools/src/samtools/misc/seqtk
H3K4 data appears to be in SOLID format:
Tried both converting to +33 and +62 formats with convert_quality.py
Fastqc could only work on +62 one, however.
The data is assumed to be the prefiltered one:

find / -name 'fastqc' 2>/dev/null

Dealing with H3K27 data:
	E17: 	decrease in quality as nucleotide progresses in each (36-bp) read
	PN15:	how to deal with N's




Week of 10/22/2012

10/24/2012

Retinal Development Project
*_tfbs_ctcf.txt			:	LICR TFBS	wgEncodeLicrTfbsCortexCtcfMAdult8wksC57bl6StdPk
*_tfbs_pol2.txt		:	LICR TFBS 	wgEncodeLicrTfbsCortexPol2MAdult8wksC57bl6StdPk







Week of 10/15/2012

cat mm9_TSS.gtf | awk -F "\t" 'OFS="\t" {print $1,$2,$3,$4,$5,$6,".",$8,$9}'

mm9_kgXref.txt contains the table for UCSC id to GeneSymbol

Retina_Genes_123.txt contains the 123 genes demonstrating the change in either H3K27me2 or H3K4me3 during retinal development (?)

filter_genes.py
	Input: GTF file, Included gene list (geneSymbol), Xref file (kgXref.txt)
	Output: stdout, GTF formatted line containing only the genes to be included




Week of 10/08/2012
10/10/2012
cat mm9.txt | awk 'OFS="\t" {print $2, "mm9_knownGene", "CDS", $4, $5, "0.000000", $3, ".", "gene_id \""$1"\"""; ""protein_id \""$6 "\""}' | grep -v "#" > mm9_TSS.gtf

10/12/2012
Filename							Reads (-1)		Signal (awk '{sum += $4} END {print sum}'
E17_H3K27me3.bedGraph.v2.txt		4,362,442		11,912,900
E17_H3K4me2.bedGraph.v2.txt		3,609,377		11,245,402
PN15_H3K27me3.bedGraph.v2.txt	5,500,682		11,844,300
PN15_H3K4me2.bedGraph.v2.txt		1,853,760		11,448,600

cat mm9.bed | wc -l
55419
wc -l mm9_TSS.gtf 
55419 mm9_TSS.gtf


cat mm9.bed | awk '{OFS="\t"} $6 == "-" {print $1, $3-5000, $3+5000}' > mm9.tss.bed
cat mm9.bed | awk '{OFS="\t"} $6 == "+" {print $1, $2-5000, $2+5000}' >> mm9.tss.bed

BedTools
Notes: bed starts at position 0, gff starts at position 1
-a:		
-b:		stored in memory (smaller file)

Filename							Reads (-1)		No Overlap (mm9.tss.bed: 15110, 27368, 42734, 42735, 42736 start_position < 5000)	Signal (Overlap)
E17_H3K27me3.bedGraph.v2.txt		4,362,442		3,690,922 (84.6%) --> 671,520 (-1) (also -u option)									2,749,380 (4.09/read)
E17_H3K4me2.bedGraph.v2.txt		3,609,377		2,806,889 (77.8%) --> 802,488 (-1)												3,957,770 (4.93/read)
PN15_H3K27me3.bedGraph.v2.txt	5,500,682		4,740,491 (86.2%) --> 760,191 (-1)												2,045,510 (2.69/read)
PN15_H3K4me2.bedGraph.v2.txt		1,853,760		1,334,642 (72.0%) --> 519,118 (-1)												4,437,020 (8.55/read)


Looking at the DHSs:
cat mm9_retina_A1w_H_1_UW.txt | awk 'OFS="\t" {print $1, "mm9_DHS_retina_A1wH1_UW", "DHS", $2, $3, $7, $6, ".", "id \""$4"\""}' | grep -v "#" > mm9_DHS_retina_A1wH1_UW.gtf

Data adjusted by (data - minimum) / range




=
