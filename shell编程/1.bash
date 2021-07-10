Shell Scripts

#使用操作系统
Linux: 服务器  网站服务

#编译型语言
C C++ java (源码 编译 计算机运行)
#解释性语言
awk Perl Python Shell
#shell 好处
	1.简单；
	2.可移植性；
	3.高效；

掌握：
系统（Linux）命令；
---------------------------------
#实验环境：

1、安装Linux系统（CentOS7）
2、Xmanager5（Xshell） 
3、VMware Workstation （虚拟机）
---------------------------------

vim :Linux系统中的编辑器
（i 插入 esc 退出，：进入末行模式，wq 保存退出 q直接退出）


first 编写第一个脚本

#脚本内容：
#!/bin/bash   #脚本的声明
#This is my first script!   #注释信息  描述信息
#echo Hello World !

echo "Hello World!"

#输出
[root@node1 ~]# sh first.sh 
Hello World!
