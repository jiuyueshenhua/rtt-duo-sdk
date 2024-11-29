#!/bin/bash



IMAGE_PATH=$1
if [ -z "$IMAGE_PATH" ]; then
	echo "Error: Little Kernel argument is missing"
	exit 1
fi
set -e


# 默认在prebuild目录下
function do_combine()
{
	BLCP_IMG_RUNADDR=0x05200200
	BLCP_PARAM_LOADADDR=0
	NAND_INFO=00000000
	NOR_INFO='FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
	FIP_COMPRESS=lzma

	BUILD_PLAT=fsbl/build/${DPT_BOARD_TYPE}
	#分类名要统一

	CHIP_CONF_PATH=${BUILD_PLAT}/chip_conf.bin
	DDR_PARAM_TEST_PATH=fsbl/test/cv181x/ddr_param.bin
	BLCP_PATH=fsbl/test/empty.bin

	MONITOR_PATH=opensbi/build/fw_dynamic.bin
	LOADER_2ND_PATH=u-boot/build/${DPT_BOARD_TYPE}/u-boot-raw.bin
	BLCP_2ND_PATH=${IMAGE_PATH}

	mkdir -p ${DPT_PATH_OUTPUT}/${DPT_BOARD_TYPE}

	echo "Combining fip.bin..."
	. ./fsbl/build/${DPT_BOARD_TYPE}/blmacros.env && \
	./fsbl/plat/fiptool.py -v genfip \
	${DPT_PATH_OUTPUT}/${DPT_BOARD_TYPE}/fip.bin \
	--MONITOR_RUNADDR="${MONITOR_RUNADDR}" \
	--BLCP_2ND_RUNADDR="${BLCP_2ND_RUNADDR}" \
	--CHIP_CONF=${CHIP_CONF_PATH} \
	--NOR_INFO=${NOR_INFO} \
	--NAND_INFO=${NAND_INFO} \
	--BL2=${BUILD_PLAT}/bl2.bin \
	--BLCP_IMG_RUNADDR=${BLCP_IMG_RUNADDR} \
	--BLCP_PARAM_LOADADDR=${BLCP_PARAM_LOADADDR} \
	--BLCP=${BLCP_PATH} \
	--DDR_PARAM=${DDR_PARAM_TEST_PATH} \
	--BLCP_2ND=${BLCP_2ND_PATH} \
	--MONITOR=${MONITOR_PATH} \
	--LOADER_2ND=${LOADER_2ND_PATH} \
	--compress=${FIP_COMPRESS}	
}

pushd "${DPT_PATH_ROOT}/prebuild"
echo "combining start..."
do_combine
echo "combining done!"
popd

