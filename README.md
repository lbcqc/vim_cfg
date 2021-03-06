# VIM 配置

记录 VIM 的配置过程，目标在于将vim打造成适用于c/c++，go，python，java等语言的编辑开发环境。

该文档主要以 centos7 为例，由于 yum 源过旧，很多时候需要源码安装，更需要记录下来安装过程。

如果是 macos 则更为简单，能 brew 安装的直接 brew 安装即可，通常都接近最新版。

其应具备如下主要功能：补全，跳转，查找，格式化，语法检测错误，快速注释，git支持，debug调试，
快速编译运行。

最终效果：
![image](./vim_edit_show.jpg)

DEBUG效果:
![image](./vim_debug_show.jpg)

## oh-my-zsh

vim 使用场景常和命令行打交道，使用 zsh 替换 bash 提供命令补全提示等功能。

- 使用 curl 安装

  ```bash
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```

- 或者使用 wget 安装

  ```bash
  sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  ```

- 修改主题

  在配置文件 `~/.zshrc` 中找到 `ZSH_THEME` 关键字修改。

  可选择的主题参考<https://github.com/ohmyzsh/ohmyzsh/wiki/Themes>

  推荐极简主题 `simple`

  也可选择本工程自定义的 `arrow-apple` 主题，安装该主题如下：

  ![image](./arrow-apple.png)

  ```bash
  cp -f ~/vim_cfg/arrow-apple.zsh-theme ~/.oh-my-zsh/themes/arrow-apple.zsh-theme
  ```

- 安装插件

  在配置文件 `~/.zshrc` 中修改 `plugins`

  ```bash
  plugins=(
    git
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
  )
  ```

  `git` 和 `z` 插件是自带的，但是另外两个插件需要手动安装，如下：

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

## tmux

tmux配合vim使用事半功倍，此处不安装无影响，可自行选择。

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
  # 解决xshell下tmux与vim颜色冲突问题，
  # 在vimrc中添加set t_Co=256
  # 在/etc/profile中添加如下三个指令：
  # export TERM="screen-256color"
  # export LANG="en_US.UTF-8"
  # export LC_ALL="en_US.UTF-8"
  set -g default-terminal "screen-256color"

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

  进入tmux任意会话：`PREFIX + I` 安装插件

## xshell(windows) or iterms2(macos)

更改颜色主题为 [solarized](https://gist.github.com/clyfish/1505019)，不建议 xshell 使用 solarized 主题，很丑，自带的 xterm 主题更适合 xshell。

安装 `Hack Nerd Font Mono` 字体，这样显示一些状态栏，及 `NERDTree` 的状态图标才不会乱码，官网：<https://github.com/ryanoasis/nerd-fonts>

或者直接使用本工程中的：[Hack Nerd Font Mono](./Hack_Regular_Nerd_Font_Complete_Mono.ttf)

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

- 安装 vim-plug 插件管理器

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

- 安装vimspector

  - 该插件是用来调试 `c/cpp`, `go`, `python`, `java`, `bash`，`lua` 等语言的。

    ```bash
    cd ~/.vim/plugged/vimspector/
    ./install_gadget.py --all    # 安装所有语言调试支持，如果只需要 c/c++ 则为 --enable-c，go 则为 --enable-go
    ```

  - 拷贝调试配置文件到工程目录

    ```bash
    cp ~/vim_cfg/cpp.lldb.vimspector.json .vimspector.json  # 在macos调试cpp工程
    cp ~/vim_cfg/cpp.gdb.vimspector.json .vimspector.json   # 在linux调试cpp工程
    cp ~/vim_cfg/go.dlv.vimspector.json .vimspector.json    # 调试go工程
    cp ~/vim_cfg/python.vimspector.json .vimspector.json    # 调试python工程
    cp ~/vim_cfg/java.vimspector.json .vimspector.json      # 调试java工程
    cp ~/vim_cfg/bash.vimspector.json .vimspector.json      # 调试bash工程
    cp ~/vim_cfg/lua.vimspector.json .vimspector.json       # 调试lua工程
    ```

  - Debug

    如果是编译型语言，比如`java` `c-cpp`，则需要加 `-g` 参数编译。

    先按`F9`打断点，再按`F5`运行，通常有两种模式：
    1. `attach` 输入可执行文件名，再输入 `pid` 调试正在运行的程序。
    2. `launch` 输入可执行文件名，再输出运行参数即可。

    `vimspector` 提供了鼠标点击的按钮，开启 `vim` 的鼠标功能即可使用。

    ```bash
    :set mouse=a  # 开启
    :set mouse=   # 关闭
    ```

    如果要执行调试命令，输入命令`:VimspectorEval [cmd]`，或者直接在 `console` 控制台输入
    命令回车执行，不同的语言调试器提供不同程度的支持。

    调试结束后，可鼠标点击 `X` 退出，或者输入命令退出：`:VimspectorReset`，
    vimrc中已将`F2`绑定到`:VimspectorReset`，避免每次都输命令。

  - java

    `java` 不同于其他语言，其调试通过 `coc-java-debug` 插件启动，并且只能 `attach`，
    需要先使用 `debug` 模式运行程序在`5005`端口，如下：

    ```bash
    java -g Test.java
    java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y Test
    ```

    然后其他都一样了，`F9` 打断点，`F5` 启动。

  - `HUMAN` 格式快捷键

|Key|Function|
|----|----|
|F5| When debugging, continue. Otherwise start debugging.|
|F3| Stop debugging.|
|F4| Restart debugging with the same configuration.|
|F6| Pause debugee.|
|F9| Toggle line breakpoint on the current line.|
|\<leader\>F9| Toggle conditional line breakpoint on the current line.|
|F8| Add a function breakpoint for the expression under cursor.|
|F10| Step Over|
|F11| Step Into|
|F12| Step out of current function scope.|

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

- 通用快捷键

  - K 查看当前变量或函数说明文档
  - gd 查找函数变量及 import 的文件定义
  - gt 查找类型定义
  - gr 查找变量或函数本地引用，注意要么回车选择一个，要么esc退出，不要ctrl-w q关闭窗口，会卡死
  - ctrl-] 和 gd 相同
  - ctrl-\ c 查看函数变量全局被调用
  - ctrl-o 返回上一个浏览位置，vim原生自带，通常用在查看定义后返回原处
  - ctrl-i 返回下一个浏览绘制，vim原声自带

- 通用补全快捷键

  - tab 跳转到下一个补全
  - shift-tab 跳转到上一个补全
  - cr 回车，确定使用当前补全
  - ctrl-a 手动重新触发补全

- c/c++ 工程

  - 如果是 `git` 工程，则直接在工程根目录直接打开即可
  - 如果不是，则在工程根目录创建 `.project` 文件
  - 打开工程之后 vim-gutentags 插件将会自动生成该工程的 gtags-cscope 索引到 `~/.cache/tags` 目录下
  - 此时可跳转补全查找引用等信息

  c/c++ 常用快捷键

  - ctrl-\ d 查看函数变量定义
  - ctrl-\ f 查找并打开该文件，通常为头文件
  - ctrl-\ s 查找该符号, 该命令不如直接用ack grep整个工程好用
  - ctrl-\ t 查找该文本，该命令不如直接用ack grep整个工程好用

  c/c++ 正确编译姿势1
  - ctrl-z 暂时退出
  - make
  - fg 回到 vim

  c/c++ 正确编译姿势2（前提是cmake初始化过一次，这样cmake命令才能找到build目录）
  - :cmake 命令
  - :make 命令

- go 工程

  常用快捷键如下，打开工程和 c/c++ 一样

  - gY 运行该文件
  - gT 运行当前测试函数

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
- n 跳转到下一个高亮，vim原生自带
- N 跳转到上一个高亮，vim原声自带
- ;n 跳转到下一个quickfix窗口列表项，在ack，cs等查找引用命令后，查找处很多项，可使用这个快捷键
- ;p 跳转到上一个quickfix窗口列表项，在ack，cs等查找引用命令后，查找处很多项，可使用这个快捷键
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
- 在:Gstatus环境下，dd 相当与git diff，查看当前文件的修改
- :Gpush origin master 提交
- :Gpull origin master 更新
- :Gdiff 查看当前文件的修改
- :Gblame 相当于 git blame
- \<space\> j 快速向下跳转到指定行，easymotion插件，其实开启了相对行号后，上下的行号更好用，比如向下跳9行，9-
- \<space\> h 快速向下跳转到指定行，easymotion插件，其实开启了相对行号后，上下的行号更好用，比如向上跳9行，9+
- ;c\<space\> 注释或者取消注释，可使用v选择多行
- za 折叠 or 打开当前代码块，vim 原生快捷方式
- zM 折叠所有代码块，vim 原生快捷方式
- zR 展开所有代码块，vim 原生快捷方式
- :PlugInstall 安装插件，只需在vimrc上的Plug列表中加入 gitub 地址即可
- :PlugClean 卸载插件，将对应的 Plug 注释掉即可
- :PlugUpdate 更新插件
- :MarkdownPreview 预览markdown文件，该命令需要在图型界面使用，如果远程linux本身有图形界面有浏览器，
xshell有插件可以打开远程浏览器，则也可以使用该命令。
