# 前提准备

需要安装RTT 仓库的bsp/cvitk目录下的mkimage二进制安装文件。

```Python
sudo cp /path/to/mkimage /usr/local/bin/
sudo chmod +x /usr/local/bin/your-binary
```


配置RT thread镜像的路径。
（To汪老师：这里我选择路径指到二进制，而不是bsp目录下，因为如果这样做我们依赖了rtt仓库的目录结构，会对rtt仓库有一定限制）

配置大核镜像路径：

`export DPT_PATH_BIG_KERNEL=/path/to/*.bin`

生成文件为 `./output/board/boot.sd`

配置小核镜像路径：

`export DPT_PATH_LITTLE_KERNEL=/path/to/*.bin`

生成文件为 `./output/board/fip.bin`

# 打包命令用法

在根目录下直接执行`./mkpkg` 会只打包大核镜像。

`./mkpkg -h`显示参数说明和支持的开发板。

```Shell
./mkpkg.sh -h
Usage:   mkpkg [-b board] [-a] [-h]
  [board]   - Supported development boards are as follows:
                  milkv-duos-sd
  -a        - Additional compilation of small core images
  -h        - Show this help message and exit.
```


以该命令为例：`./mkpkg.sh -b milkv-duos-sd -a`  该命令会以duos-sd开发板为对象，存储类型为sd卡，打包大核镜像后继续打包小核镜像。

本仓库默认开发板为milkv-duos-sd。可在`~/.bashrc`文件通过`export DPT_BOARD_TYPE=`来配置开发板类型。



# 脚本解释（后面会删）

三个实习生的仓库的目录框架都是相似的，融合时要考虑的反而是脚本。所以为了协作，有必要去说明自己写的脚本框架。


个人习惯是如果作用域为全局的变量，则必须在`mkpkg.sh`文件开头声明，且变量名以DPT开头。
mkpkg主要负责参数解析，打印显示，调用模块等无副效果的操作。有副效果的语句尽量用文件隔离开。

整个脚本框架主要为解析参数，打包镜像，配置变量这三大模块。

`image_tool`目录下是打包大核镜像会用到的脚本。

`env_tool`：主要提供访问，更新配置变量的工具

`args_handler`:提供对应参数的动作

`combine-fip`:执行打包小核镜像的动作

`mksdimg`:执行打包大核镜像的动作



如何增添对新开发板的支持？

参考`mksdimg`，`combine-fip`文件，补充对应的prebuild二进制文件和dts文件。

脚本会读取dtb目录，来更新可支持的开发板类型。



