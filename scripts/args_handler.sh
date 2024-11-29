#!/bin/bash

# 显示帮助信息
usage() {
  echo "Usage:   mkpkg [-b board] [-a] [-h]"
  echo "  [board]   - Supported development boards are as follows:"
  print_all_boards
  echo "  -a        - Additional compilation of small core images"
  echo "  -h        - Show this help message and exit."  
}


# 执行与 -a 相关的操作
handle_a() {
  ./scripts/combine-fip.sh ${DPT_PATH_LITTLE_KERNEL}
}

