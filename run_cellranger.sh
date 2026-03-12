
#!/bin/bash

# 1. 定义路径
REF="/media/desk16/iy11913/zhailab/reference/refdata-gex-GRCm39-2024-A"                   # 替换成自己的参考文件目录
FASTQ_DIR="/media/desk16/iy11913/zhailab/pabpc_testis/10×single_cell"                     # 替换10×genomic测序的fastq.gz文件目录
OUT_DIR="/media/desk16/iy11913/zhailab/pabpc_testis/10×single_cell/result_force_cell"     # 设置输出目录

# 创建输出目录（如果不存在）
mkdir -p $OUT_DIR
cd $OUT_DIR

# 2. 自动获取样本名称
# 逻辑：寻找以 .fq.gz 结尾的文件，取出第一个 '_' 之前的字符串作为样本名，并去重
SAMPLES=$(ls $FASTQ_DIR/*.fastq.gz | xargs -n 1 basename | cut -d'_' -f1 | sort | uniq)

echo "检测到以下样本进行处理: $SAMPLES"

# 3. 循环运行 Cell Ranger
for SAMPLE in $SAMPLES
do
    echo "正在开始处理样本: $SAMPLE"

    # 注意：下面的 $OUT_DIR, $REF, $FASTQ_DIR 全都加上双引号
    cellranger count --id="$SAMPLE" \              # 输出目录的名字（建议包含样本名和日期）。
                     --transcriptome="$REF" \      # 参考基因组指数的路径。对于小鼠，通常使用官方提供的 mm10 或 GRCm39。
                     --fastqs="$FASTQ_DIR" \       # 存放原始测序数据（FASTQ 文件）的文件夹路径
                     --sample="$SAMPLE" \          # FASTQ 文件名的前缀（例如文件名为 sample_name_S1_L001_R1_001.fastq.gz，这里就填 sample_name）
                     --localcores=36 \             #  限制使用的 CPU 核心数（建议根据服务器配置设定，不要超过总核数）。
                     --localmem=128 \              #  限制使用的内存大小（单位 GB，单细胞处理非常吃内存，建议每个样本至少分配 64GB）。
                     --create-bam=true
		    #  --force-cells=15000                   # 可选，建议第一次跑，不要设置

    echo "样本 $SAMPLE 处理完成"
done
