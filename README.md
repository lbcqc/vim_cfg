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

[下载 llvm_project](https://releases.llvm.org/download.html)

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

## 更新 gcc

[下载地址](https://mirrors.ustc.edu.cn/gnu/gcc)
