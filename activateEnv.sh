#!/bin/bash
###
 # @Author: Mr.Car
 # @Date: 2024-05-13 14:17:39
 # 这个脚本的目的是能够在使用工具时自动省略掉手动激活虚拟环境这一步 “conda activate selfPythonTools”
 # 但是事实情况是，很难在短时间内找到办法，把这个问题很好的解决，就算实现了用脚本激活虚拟环境，但是还有一个处于中间的对象是没搞清楚的，导致虽然能够运行成功，但是当前的虚拟环境还是没有得到很好的切换
### 

# 指定要激活的 conda 环境名称
ENV_NAME="selfPythonTools"

# 激活 conda 环境
source $(conda info --base)/etc/profile.d/conda.sh
conda activate $ENV_NAME
echo $(conda env list)