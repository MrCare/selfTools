#!/bin/bash

# 显示帮助信息的函数
show_help() {
    echo "Usage: $0 <pdf_file> <number_of_parts>"
    echo "Splits a PDF file into a specified number of parts using qpdf."
    echo
    echo "  pdf_file: Path to the PDF file to split."
    echo "  number_of_parts: Number of parts to split the PDF file into."
    echo
    echo "Example: $0 /path/to/file.pdf 3"
}

# 检查是否传入了足够的参数
if [ "$#" -ne 2 ]; then
    show_help
    exit 1
fi

# 特殊参数处理，比如 -h 或 --help
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

pdf_file=$1
number_of_parts=$2

# 检查文件是否存在
if [ ! -f "$pdf_file" ]; then
    echo "File does not exist: $pdf_file"
    exit 1
fi

# 获取PDF的总页数
total_pages=$(qpdf --show-npages "$pdf_file")

# 计算每部分的页数
pages_per_part=$((total_pages / number_of_parts))
remainder=$(($total_pages % number_of_parts))

# 初始化起始页
start_page=1

for (( part=1; part<=number_of_parts; part++ ))
do
    end_page=$(($start_page + $pages_per_part - 1))

    # 在最后一部分添加剩余的页
    if [ $part -eq $number_of_parts ]; then
        end_page=$(($end_page + $remainder))
    fi

    # 使用qpdf分割PDF
    qpdf "$pdf_file" --pages "$pdf_file" $start_page-$end_page -- "${pdf_file%.pdf}_part$part.pdf"

    # 更新起始页
    start_page=$(($end_page + 1))
done
