#!/bin/bash

# 获取 dtb 目录下的所有子目录名字并存入 all_boards 数组
function get_all_boards()
{
    dtb_dir=${DPT_PATH_ROOT}/prebuild/dtb
	DPT_ALL_BOARDS=($(find "$dtb_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
}

function print_all_boards()
{
    for item in "${DPT_ALL_BOARDS[@]}"; do
    echo "                  $item"
    done
}

function check_board()
{
    if [[ " ${DPT_ALL_BOARDS[@]} " =~ " ${DPT_BOARD_TYPE} " ]]; then
        echo "$DPT_BOARD_TYPE 存在于 ${DPT_ALL_BOARDS[@]} 中"        
    else
        echo "$DPT_BOARD_TYPE 不存在于 ${DPT_ALL_BOARDS[@]}  中"
        exit 1
    fi
}

get_storage() {
    
    # 使用 - 分割 board 字符串，并将结果存入数组
    IFS='-' read -r -a parts <<< "$DPT_DPT_BOARD_TYPE"    
    
    # 如果 board 中有第三个部分，使用它作为 storage，否则使用默认值 'sd'
    if [[ ${#parts[@]} -ge 3 ]]; then
        DPT_STORAGE_TYPE=${parts[2]}
    else
        DPT_STORAGE_TYPE="sd"
    fi
}
