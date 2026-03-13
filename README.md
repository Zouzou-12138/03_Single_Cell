
---

# 📊 Single-Cell RNA-Seq Analysis Pipeline

## Environment Configuration

```bash
# Create environment (using mamba for faster resolution)
mamba env create -f environment.yml

# Activate environment
conda activate single_cell

```

---

## 📥 1. Cell Ranger Installation

### 1.1 Download Software

Download Cell Ranger from the 10x Genomics official website:
`https://www.10xgenomics.com/support/software/cell-ranger/downloads`

### 1.2 Installation Steps

```bash
# Decompress the package (choose based on your download format)
# For .tar.gz format:
tar -xzvf cellranger-10.0.0.tar.gz

# For .tar.xz format:
# tar -xvf cellranger-10.0.0.tar.xz

# Add software path to system environment variables
# ⚠️ Note: Replace "/your/actual/path" with your real installation directory
echo 'export PATH=/your/actual/installation/path/cellranger-10.0.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Verify installation
cellranger --version

```

### 1.3 Download Reference Genomes

Download the relevant reference genome for your species:
`https://www.10xgenomics.com/support/software/cell-ranger/downloads#reference-downloads`

**Common Reference Genomes:**

* **Human (GRCh38)**: `refdata-gex-GRCh38-2024-A`
* **Mouse (GRCm39)**: `refdata-gex-GRCm39-2024-A`
* **Rat (mRatBN7.2)**: `refdata-gex-mRatBN7-2-2024-A`

```bash
# Example: Download Mouse Reference Genome
cd /path/to/reference/directory
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCm39-2024-A.tar.gz
tar -xzvf refdata-gex-GRCm39-2024-A.tar.gz

```

---

## 🔬 2. Data Processing Workflow

### 2.1 Fastq File Descriptions

Each scRNA-seq sample typically consists of two critical files:

| File | Content | Role |
| --- | --- | --- |
| `L001_R1_001.fastq.gz` | 16 bp Cell Barcode + 10 bp UMI | **Cell Identity**: Distinguishes individual cells and corrects PCR amplification bias via UMIs. |
| `L001_R2_001.fastq.gz` | cDNA Fragment Sequence | **Gene Expression**: Aligned to the genome to quantify gene expression levels. |

### 2.2 Running Cell Ranger

**Execution Script:**

```bash
# Grant execution permissions
chmod +x run_cellranger.sh

# Run in background (Recommended)
nohup ./run_cellranger.sh > output.log 2>&1 &

# Monitor logs
tail -f output.log

```

### 2.3 Output File Descriptions

Upon successful completion, the following key files are generated in the output directory:

```text
[Sample_Name]/
├── outs/
│   ├── filtered_feature_bc_matrix/    # Expression matrix for downstream analysis
│   ├── web_summary.html                # Quality Control (QC) report (HTML)
│   ├── metrics_summary.csv             # Summary of QC metrics
│   ├── molecule_info.h5                 # Molecule-level information
│   └── possorted_genome_bam.bam         # Aligned BAM file (if --create-bam is enabled)

```

---

## 📊 3. Downstream Analysis

### 3.1 R-based Analysis

**Analysis Notebook**: 
`downstream_analysis.ipynb` 

---

  