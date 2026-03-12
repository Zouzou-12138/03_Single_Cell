
# 📊 单细胞测序数据分析流程

# 环境配置
# # 创建环境
conda env create -f environment.yml #  有mamba， 将conda替换成mamba
 
# 激活环境
conda activate single_cell

## 📥 1. Cell Ranger 软件安装

### 1.1 下载软件
从 10x Genomics 官网下载 Cell Ranger：
```
https://www.10xgenomics.com/support/software/cell-ranger/downloads
```

### 1.2 安装步骤
```bash
# 解压安装包（根据下载格式选择其一）
# 对于 .tar.gz 格式
```
tar -xzvf cellranger-10.0.0.tar.gz


# 对于 .tar.xz 格式
# tar -xvf cellranger-10.0.0.tar.xz

# 将软件路径添加到系统环境变量
# ⚠️ 注意：将 "path" 替换为实际的安装路径
```
echo 'export PATH=/your/actual/installation/path/cellranger-10.0.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```
# 验证安装
cellranger --version

# 如果能显示版本信息，则说明安装成功
```

### 1.3 下载参考基因组
从官网下载对应物种的参考基因组：
```
https://www.10xgenomics.com/support/software/cell-ranger/downloads#reference-downloads
```

常用的参考基因组：
- **人 (GRCh38)**：refdata-gex-GRCh38-2024-A
- **小鼠 (GRCm39)**：refdata-gex-GRCm39-2024-A
- **大鼠 (mRatBN7.2)**：refdata-gex-mRatBN7-2-2024-A

```bash
# 示例：下载小鼠参考基因组
cd /path/to/reference/directory
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCm39-2024-A.tar.gz
tar -xzvf refdata-gex-GRCm39-2024-A.tar.gz
```

## 🔬 2. 数据处理流程

### 2.1 数据文件说明
单细胞测序每个样本包含两个关键文件：

|          文件          |               内容            |           作用                               |
| `L001_R1_001.fastq.gz` | 16 bp 细胞Barcode + 10 bp UMI | **细胞身份信息**：区分不同细胞，校正PCR扩增偏差 |
| `L001_R2_001.fastq.gz` | cDNA片段序列                  | **基因表达信息**：比对到基因组，获取基因表达量   |

### 2.2 运行 Cell Ranger


**运行脚本**：
```
# 添加执行权限
chmod +x run_cellranger.sh
# 后台运行（推荐）
nohup ./run_cellranger.sh > output.log 2>&1 &
# 查看运行日志
tail -f output.log
```

### 2.3 输出结果说明
运行成功后，在输出目录中会生成以下重要文件：

```
[样本名]/
├── outs/
│   ├── filtered_feature_bc_matrix/    # 下游分析用的表达矩阵
│   ├── web_summary.html                # 质控报告（网页版）
│   ├── metrics_summary.csv             # 质控指标汇总
│   ├── molecule_info.h5                 # 分子信息文件
│   └── possorted_genome_bam.bam         # 比对后的BAM文件（如启用--create-bam）
```

## 📊 3. 下游分析

### 3.1 R语言分析
**运行脚本**：使用jupyter或者R跑downstream_analysis.ipynb的代码
downstream_analysis.ipynb



  