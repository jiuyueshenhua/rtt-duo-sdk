#!/bin/sh
set -e
# 脚本遇到错误立刻退出，而不是执行下一条命令

#传入一个路径
IMAGE_PATH=$1

echo ${IMAGE_PATH}
if [ -z "$1" ]; then
	echo "Error: Big Kernel argument is missing"
	exit 1
fi



echo "start compress kernel..."

lzma -c -9 -f -k ${IMAGE_PATH} > ${DPT_PATH_ROOT}/prebuild/dtb/${DPT_BOARD_TYPE}/Image.lzma

mkdir -p ${DPT_PATH_OUTPUT}/${DPT_BOARD_TYPE}
mkimage -f ${DPT_PATH_ROOT}/prebuild/dtb/${DPT_BOARD_TYPE}/multi.its -r ${DPT_PATH_OUTPUT}/${DPT_BOARD_TYPE}/boot.${DPT_STORAGE_TYPE}

echo "compress done"
rm ${DPT_PATH_ROOT}/prebuild/dtb/${DPT_BOARD_TYPE}/Image.lzma

