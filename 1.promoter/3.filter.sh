#!/bin/bash

# 文件名
input_file="result/absolutePromoterActivity.txt.gz"
output_file="result/absolutePromoterActivity_filtered.txt.gz"

# 解压文件，处理并压缩回去
gunzip -c $input_file | awk -F'\t' '
    NR==1 {print $0;next}  
    {
        delete vals  
        total = NF - 1  
        for(i=2; i<=NF; i++) {  
            vals[$i]++
        }
        for(val in vals) {
            if (vals[val] / total >= 0.7) next  
        }
        print $0  
    }
' | gzip > $output_file
