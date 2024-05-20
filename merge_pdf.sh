#!/bin/bash
###
 # @Author: Mr.Car
 # @Date: 2024-01-09 19:39:32
### 

# 显示帮助信息的函数
show_help() {
    echo "Usage: $0 <output_pdf> <input_pdf1> <input_pdf2> [<input_pdf3> ...]"
    echo "Merges multiple PDF files into a single PDF file using qpdf."
    echo
    echo "  output_pdf: Path for the merged output PDF file."
    echo "  input_pdf1, input_pdf2, ... : PDF files to merge."
    echo
    echo "Example: $0 merged.pdf file1.pdf file2.pdf file3.pdf"
}

# 检查是否传入了足够的参数
if [ "$#" -lt 3 ]; then
    show_help
    exit 1
fi

output_pdf=$1
shift # 移除第一个参数（输出文件），剩下的都是输入文件

# 开始合并文件
qpdf --empty --pages "$@" -- "$output_pdf"

echo "Merged PDF created at: $output_pdf"
