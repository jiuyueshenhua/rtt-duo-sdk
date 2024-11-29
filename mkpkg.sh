#!/bin/bash
set -e

export DPT_BOARD_TYPE="${DPT_BOARD_TYPE:-milkv-duos-sd}"
export DPT_STORAGE_TYPE=sd
DPT_PATH_BIG_KERNEL=/home/catcatbing/dev/project/join_rtt/rt-thread/bsp/cvitek/cv18xx_risc-v/Image
DPT_PATH_LITTLE_KERNEL=/home/catcatbing/dev/project/join_rtt/rt-thread/bsp/cvitek/c906_little/rtthread.bin
export DPT_PATH_ROOT=$(pwd)
export DPT_PATH_OUTPUT=${DPT_PATH_ROOT}/output
export DPT_ALL_BOARDS=

source ${DPT_PATH_ROOT}/scripts/env_tool.sh
source ${DPT_PATH_ROOT}/scripts/args_handler.sh

h_flag=
a_flag=
b_flag=

while getopts "hba" opt; do
    case $opt in
    h)
        h_flag=t
        ;;
    b)
        board=${!OPTIND}

        if [[ -z "$board" || "$board" == -* ]]; then
        echo "Exiting: board is empty "
        exit 1
        fi
                
        DPT_BOARD_TYPE=$board
        ;;
    a)
        a_flag=t
        ;;
    *)        
        usage
        exit 1
        ;;
    esac
done

get_all_boards
if [ -n "$h_flag" ]; then
    usage
    exit 0
fi


check_board
get_storage

./scripts/mksdimg.sh ${DPT_PATH_BIG_KERNEL}

if [ -n "$a_flag" ]; then    
    handle_a
fi