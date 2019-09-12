[TOC]

# 服务器配置(基于Ubuntu)

建议以下命令均在`root`权限下运行

## 下载安装SSH

打开终端(Terminal)执行如下命令,如果已经安装了ssh就直接跳到下一步即可

```shell
apt-get unpdate

apt-get install openssh-server
```

在执行过程中会提示是否希望继续执行,选择`y`继续执行,下载完成之后启动SSH

```shell
/etc/init.d/ssh start # 启动ssh

# 关闭和重启命令如下
/etc/init.d/ssh stop  # 关闭ssh
/etc/init.d/ssh restart  # 重启ssh
```

接下来配置root用户SSH服务

打开`/etc/ssh/sshd_config`

```shell
nano /etc/ssh/sshd_config
```

键入`Ctrl+w`查找是否有`PermitRootLogin yes`内容,如果有,直接`Ctrl+x`退出即可(留意前面是否有`#`)

如果这一行前面有`#`,那么需要删除`#`,如果这一行内容为`PermitRootLogin no`,那么需要修改`yes`为`no`

如果找不到这一行内容,直接在文档内添加即可

完成后`Ctrl+x`,然后键入`y`,再键入`enter`即可保存并退出

之后在客户端电脑(也就是自己的电脑)上执行以下命令,执行过程中一路`enter`即可

```shell
ssh-keygen -t rsa
```

接下来进入`/root/.ssh`目录,将公钥上传至服务端(将10.10.10.10替换成自己的服务器地址)

```shell
cd /root/.ssh # 进入/root/.ssh目录

scp id_rsa.pub root@10.10.10.10:/root
```

接下来在服务器端`/root`目录下创建`.ssh`文件夹(如果有就不需要创建了),然后执行以下命令

```shell
cd /root

mkdir .ssh

cat id_rsa.pub >>/root/.ssh/authorized_keys

chmod 600 /root/.ssh/authorized_keys
```

然后进入服务端`/etc/ssh`目录,打开`sshd_config`

```shell
cd /etc/ssh

nano sshd_config
```

修改或启用以下内容

```txt
RSAAuthentication yes # 开启rsa验证
PubkeyAuthentication yes # 是否使用公钥
AuthorizedKeysFile .ssh/authorized_keys # 公钥保存位置
PasswordAuthentication no # 禁止使用密码登录
```

之后重启ssh

```shell
service sshd restart
# 或者使用以下命令
/etc/init.d/ssh restart  # 重启ssh

```

接下来就可以用客户端电脑通过ssh密钥的方式登录服务器了(将10.10.10.10替换成自己的服务器ip地址)

```shell
ssh root@10.10.10.10

```

## 实现代理功能

登录服务器后执行以下命令

```shell
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh

```

然后依照提示依次配置即可(未安装过SSR的服务器在第一个提示出现时输入1)

在提示设置端口的时候可以用默认的,也可以用自己的,但是切记不要使用1080以前的端口,建议3000-30000之间

设置完成后等待几分钟就好了

具体可以查看此链接:[配置SSR](https://www.textarea.com/vultr/shoubashou-jiao-ni-dajian-shadowsocksr-kexue-shangwang-dajian-ssr-jiaocheng-shiyong-yu-suoyou-linux-zhuji-1046)

## 开启BBR加速

在服务器`root`账号下执行以下命令

```shell
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

```

安装过程中可能提示需要重启`VPS`,输入`y`即可,如果没有出现也不用关心

