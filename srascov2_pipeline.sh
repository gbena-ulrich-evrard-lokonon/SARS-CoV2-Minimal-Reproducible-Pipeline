#!/bin/bash

# ============================
# Minimal SARS-CoV-2 Pipeline
# Auteur: Gbéna Ulrich Evrard LOKONON
# Description: Simple, reproducible, clean workflow
# ============================

set -e  # stop si erreur

# ========= VARIABLES =========
SAMPLE="sample"
REF="reference.fasta"

R1="data/${SAMPLE}_1.fastq"
R2="data/${SAMPLE}_2.fastq"

CLEAN_R1="data/clean_${SAMPLE}_1.fastq"
CLEAN_R2="data/clean_${SAMPLE}_2.fastq"

# ========= DOSSIERS =========
mkdir -p qc results

echo "🚀 Starting pipeline for $SAMPLE"

# ========= QC =========
echo "📊 Running FastQC..."
fastqc $R1 $R2 -o qc/

# ========= TRIMMING =========
echo "✂️ Running fastp..."
fastp -i $R1 -I $R2 \
-o $CLEAN_R1 -O $CLEAN_R2 \
-h qc/${SAMPLE}_fastp.html

# ========= ALIGNEMENT =========
echo "🧬 Running BWA..."
bwa mem $REF $CLEAN_R1 $CLEAN_R2 > results/${SAMPLE}.sam

# ========= BAM =========
echo "🔄 Processing BAM..."
samtools view -bS results/${SAMPLE}.sam | \
samtools sort -o results/${SAMPLE}.bam

samtools index results/${SAMPLE}.bam

# ========= STATS =========
samtools flagstat results/${SAMPLE}.bam > results/${SAMPLE}_stats.txt

# ========= VARIANTS =========
echo "🧪 Calling variants..."
freebayes -f $REF results/${SAMPLE}.bam > results/${SAMPLE}.vcf

echo "✅ Pipeline completed"