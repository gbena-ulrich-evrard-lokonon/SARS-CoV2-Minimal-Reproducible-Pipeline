🧬 Minimal SARS-CoV-2 NGS Pipeline

   


---

📌 Overview

This project provides a lightweight, reproducible, and easy-to-use bioinformatics pipeline for the analysis of SARS-CoV-2 sequencing data.

It is designed with a focus on:

Simplicity

Reproducibility

Accessibility in low-resource environments


The pipeline performs a complete workflow from raw sequencing reads to variant calling.


---

🧾 Dataset and Reference

🧬 Reference genome

SARS-CoV-2 isolate Wuhan-Hu-1

Accession: NC_045512.2

Description: Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1


📥 Sequencing data

Accession: SRR11140744

Type: Paired-end FASTQ reads


These datasets ensure full reproducibility and benchmarking.


---

📥 Data Acquisition

1️⃣ Download FASTQ files (SRA)

Recommended environment:

conda activate sra_env

prefetch SRR11140744
fasterq-dump SRR11140744

Output:

SRR11140744_1.fastq

SRR11140744_2.fastq


Move files:

mv SRR11140744*.fastq data/


---

2️⃣ Download reference genome

conda activate bioinf_ngs

eftech -db nucleotide -id NC_045512.2 -format fasta > reference.fasta


---

🎯 Objectives

Provide a minimal yet functional NGS pipeline

Facilitate training and learning in bioinformatics

Enable analysis in low-resource environments

Serve as a foundation for scalable pipelines



---

⚙️ Workflow

FASTQ => QC => Trimming => Alignment => BAM (sorted) => Variant Calling

🔬 Steps

1. Quality Control - FastQC


2. Read Cleaning - fastp


3. Alignment - BWA


4. BAM Processing - samtools


5. Mapping Statistics - samtools flagstat


6. Variant Calling - FreeBayes




---

📁 Project Structure

project/
├── data/        # Input FASTQ files
├── qc/          # Quality reports
├── results/     # BAM, VCF, stats
├── pipeline.sh  # Main pipeline script
└── README.md


---

🚀 Usage

1️⃣ Prepare data

Ensure:

data/sample_1.fastq
data/sample_2.fastq
reference.fasta

2️⃣ Run pipeline

[bash pipeline.sh](srascov2_pipeline.sh)

---

📊 Outputs

qc/ => FastQC + fastp reports

results/sample.bam => aligned reads

results/sample_stats.txt => mapping statistics

results/sample.vcf => variant calls



---

🧠 Design Philosophy

This pipeline intentionally avoids complexity to:

Improve understanding of core bioinformatics steps

Ensure reproducibility

Run on standard computers without HPC


It is suited for:

Students and beginners

Training workshops

Rapid prototyping workflows



---

🌍 Relevance

This project supports accessible bioinformatics in low-resource environments where:

Internet access may be limited

Computational resources are constrained


It can support:

Viral surveillance systems

Public health monitoring platforms

---

📊 Expected Results

Using the dataset:

- Accession: SRR11140744
- Reference: NC_045512.2 (SARS-CoV-2 Wuhan-Hu-1)

The pipeline will generate:

- [FASTQC](SRR11140744_1_fastqchtml)  ,   [FASTQC](SRR11140744_2_fastqchtml)
- [High-quality trimmed reads](clean_R1_fastqchtml)   ,    [High-quality trimmed reads](clean_R2_fastqchtml)  
- [Fastp_repport](rapport_fastp.html)
- Mapping statistics: [View file](results/covid_stats.txt) 
- Variant: [Variant file](results/variantes.vcf)  

---

🛠️ Requirements

fastqc

fastp

bwa

samtools

freebayes

sra-tools

entrez-direct



---

👤 Author

Gbèna Ulrich Evrard LOKONON
Bioinformatician | Genomics | AI for Health


---

🚀 Future Improvements

Multi-sample support

Snakemake / Nextflow automation

Docker containerization


---

📄 License

Open-source - educational and research use.
