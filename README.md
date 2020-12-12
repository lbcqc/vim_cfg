# VIM 配置

记录 VIM 的配置过程。

## tmux

- 安装 tmux

```bash
yum install -y tmux
```

- 安装插件管理 tpm

使用 git 安装

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

修改配置 ~/.tmux.conf

```bash
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'seebi/tmux-colors-solarized'
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

更新 tmux 配置

```bash
tmux source ~/.tmux.conf
```

PREFIX + I 安装插件

- xshell

更改颜色主题为 [solarized](https://gist.github.com/clyfish/1505019)

## 安装 vim8

安装 python3

```bash
sudo yum install -y git gcc-c++ ncurses-devel python-devel cmake wget make
sudo yum install -y python36 python36-devel
```

安装 vim

```bash
git clone https://github.com/vim/vim.git
```

```bash
./configure --with-features=huge \
--enable-multibyte \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-python3interp=yes \
--with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
--enable-cscope \
--enable-gui=auto \
--enable-gtk2-check \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--enable-fail-if-missing \
--prefix=/usr/local/vim
```

```bash
make -j8 && make install
echo "PATH=\$PATH:/usr/local/vim/bin" >> /etc/profile
source /etc/profile
```

## 安装 nodejs & yarn

- nodejs

```bash
wget https://nodejs.org/dist/v15.3.0/node-v15.3.0-linux-x64.tar.gz
tar -xzvf node-v15.3.0-linux-x64.tar.gz
mv node-v15.3.0-linux-x64 /usr/local/nodejs
echo "PATH=\$PATH:/usr/local/nodejs/bin" >> /etc/profile
```

- yarn

```bash
curl -o- -L https://yarnpkg.com/install.sh | bash
```

## 更新 CMake

- 卸载原 cmake

  ```bash
  yum remove cmake
  ```

- 源码安装

  [下载源码](https://cmake.org/download/)

  ```bash
  tar -xzvf cmake-x.x.x.tar.gz
  cd cmake-x.x.x
  ./boostrap
  gmake
  gmake install
  ```

## 安装格式化代码工具

- cmake-format

  cmake

  ```bash
  pip3 install cmake-format
  ```

- js-beautiful

  js html css json

  ```bash
  npm install -g js-beautify
  ```

- remark-cli

  markdown

  ```bash
  npm install -g remark-cli
  ```

- shfmt

  bash

  ```bash
  git clone https://github.com/patrickvane/shfmt.git
  cd shfmt
  mkdir build
  cd build
  go get github.com/mitchellh/gox
  gox ../cmd/shfmt/
  mv shfmt_linux_amd64 /usr/local/bin/shfmt
  cd ..
  rm -rf build
  ```

- astyle

  java

  [下载源码](https://sourceforge.net/projects/astyle/)

  ```bash
  tar -xzvf astyle.tar.gz
  cd build
  cmake ..
  make -j8
  make install
  ```

- autopep8

  python

  ```bash
  pip3 install autopep8
  ```

## 安装语法检测工具

- flake8

  ```bash
  pip3 install flake8
  ```

- eslint

  ```bash
  npm install eslint –g
  ```

## 安装 ack ctag global

- ack

  ```bash
  yum -y update
  yum -y install epel-release ack
  ```

- global

  [下载地址](https://ftp.gnu.org/pub/gnu/global/)

  ```bash
  tar -xzvf global-6.6.5.tar.gz
  cd global-6.6.5
  ./configure --prefix=/usr/local/global
  make -j8 && make install
  ln -sf /usr/local/code/global-6.6.5 /usr/local/share/gtags
  ```

- universal-ctags

  ```bash
  yum remove ctags
  git clone https://github.com/universal-ctags/ctags.git
  cd ctags
  ./autogen.sh
  ./configure --prefix=/usr/local/ctags
  make -j8
  make install
  ```

## 安装插件

- 安装 vim-plug 插件

  ```bash
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

- 安装配置

  ```bash
  git clone https://github.com/lbcqc/vim_cfg.git
  mv ~/.vimrc ~/.vimrc.bk
  ln -s ./vim_cfg/vimrc ~/.vimrc
  ```

- 安装插件

  进入 vim

  ```bash
  :PlugInstall
  ```

- 安装 Go 语言支持

  ```bash
  :GoInstallBinaries
  ```

- 修改 coc 配置

  执行 `CocConfig` 命令打开配置，复制下面的 `json` 填进去即可，注意 `java.home` 的地址要更改

  ```bash
  :CocConfig
  ```

  ```json
  {
     "suggest.enablePreview": true,
     "suggest.noselect": false,
     "suggest.minTriggerInputLength": 2,
     "coc.preferences.hoverTarget": "preview",
     "coc.preferences.previewAutoClose": false,
     "diagnostic.displayByAle": true,
     "java.home": "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"
  }
  ```

## 安装 llvm

> 注意：devcloud上内存不足，无法源码编译，可找其他 centos7 机器编译好了的直接拷贝，更快更方便。
> 其他机器 llvm 编译出来后可能依赖了更高版本的 libstdc++.so.6, 一起替换即可。

[下载 llvm_project 源码](https://releases.llvm.org/download.html)

创建 swap 分区

```bash
dd if=/dev/zero of=/data/swapfile bs=1M count=16384
chmod 0600 /data/swapfile
mkswap /data/swapfile
swapon /data/swapfile
```

```bash
xz -d llvm-project-11.0.0.tar.xz
tar -xvf llvm-project-11.0.0.tar
cd llvm-project
mkdir build
cd build
cmake ../llvm
make -j8
make install
```

## 常见用法

### 打开工程

- c/c++ 工程

  - 如果是 `git` 工程，则直接在工程根目录直接打开即可
  - 如果不是，则在工程根目录创建 `.project` 文件
  - 打开工程之后 vim-gutentags 插件将会自动生成该工程的 gtags-cscope 索引到 `~/.cache/tags` 目录下
  - 此时可跳转补全查找引用等信息

  c/c++ 常用快捷键

  - ctrl-\ c 查看函数变量被调用
  - ctrl-\ d 查看函数变量定义
  - ctrl-\ f 查找并打开该文件，通常为头文件
  - ctrl-\ s 查找该符号, 该命令不如直接用ack grep整个工程好用
  - ctrl-\ t 查找该文本，该命令不如直接用ack grep整个工程好用
  - gd 查找局部变量定义，vim原生自带
  - ctrl-] 查找函数变量定义

  c/c++ 正确编译姿势1
  - ctrl-z 暂时退出
  - make
  - fg 回到 vim

  c/c++ 正确编译姿势2（前提是cmake初始化过一次，这样cmake命令才能找到build目录）
  - :cmake 命令
  - :make 命令

- go 工程

  常用快捷键如下，打开工程和 c/c++ 一样

  - gR 运行该文件
  - gT 运行当前测试函数
  - gd 查找函数变量及 import 的文件定义
  - gt 查找类型定义
  - ctrl-] 和 gd 相同
  - ctrl-\ c 查看函数变量被调用

### 其他常用快捷键

- nt 打开或关闭nerdtree目录
- nf 打开nerdtree目录并且跳转到当前文件
- tb 打开或关闭当前文件函数变量等符号信息列表
- ctrl-w [hjkl] 跳转到左右上下窗口，vim原生自带
- ctrl-w q 关闭当前窗口
- ;a 打开ack遍历，后接要便利的字符串回车即可，效果类似grep
- ;f 模糊查找工程下所有文件，leaderf 插件功能
- ;b 模糊查找最近打开的 buffers 即文件，leaderf 插件功能
- ;t 模糊查找当前文件tag
- ;T 模糊查找当前工程Tag
- ;m 模糊找到当前文件的函数
- ;M 模糊找到当前工程的所有函数
- ;h 高亮当前字符串
- shift-\* 高亮当前关键字（此处和字符串不一样），并跳转到下一个引用处
- ;j 取消高亮
- ;n 跳转到下一个高亮
- ;p 跳转到上一个高亮
- :Autoformat 自动格式化当前文件，支持c/c++ java go python cmake markdown cs css js json html等
- ;s 关闭 or 打开 ale 语法检测，有时检测出一堆错误也很烦人
- ;d 查看 ale 检测的错误细节
- ghn 跳转到下一个修改，git插件
- ghb 跳转到上一个修改，git插件
- ghu 取消当前光标所在的修改
- ghp 预览当前光标所在的修改
- ghs 添加当前光标所在的修改到 staged 处
- :Gstatus 查看当前状态
- 在:Gstaus环境下，a 相对与add当前文件，+号也可
- 在:Gstatus环境下，u 相当与取消add当前文件，-号也可
- 在:Gstatus环境下，cc 相当与commit
- :Gpush origin master 提交
- :Gpull origin master 更新
- :Gdiff 查看当前文件的修改
- :Gblame 相当于 git blame
- \<space\> j 快速向下跳转到指定行，easymotion插件，其实开启了相对行号后，上下的行号更好用，比如向下跳9行，9-
- \<space\> h 快速向下跳转到指定行，easymotion插件，其实开启了相对行号后，上下的行号更好用，比如向上跳9行，9+
