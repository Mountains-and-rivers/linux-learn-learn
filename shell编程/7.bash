shell 运算符

expr :数值运算
expr 变量1 运算符 变量2

+
-
*
/
%
运算符与变量之间必须有一个空格；


[root@node1 ~]# A=10
[root@node1 ~]# B=20
[root@node1 ~]# expr $A+$B
10+20
[root@node1 ~]# expr $A + $B
30
[root@node1 ~]# expr $A - $B
-10
[root@node1 ~]# expr $A * $B
expr: syntax error
[root@node1 ~]# expr $A \* $B
200
[root@node1 ~]# expr $A / $B
0
[root@node1 ~]# expr $A % $B
10
---------------------------------

#结果赋值给变量 
#$()
[root@node1 ~]# abc=$(expr $A + $B)
[root@node1 ~]# echo $abc
30

#过滤IP地址
#
[root@node1 ~]# IPADDR=$(ifconfig eth0 | grep "inet" | awk '{print $2}')
[root@node1 ~]# echo $IPADDR
10.141.113.216


#双引号" "
#保留值存在空格或者特殊字符
[root@node1 ~]# webserver=nginx 1.11
-bash: 1.11: command not found
[root@node1 ~]# echo $webserver

[root@node1 ~]# webserver="nginx 1.11"
[root@node1 ~]# echo $webserver
nginx 1.11
[root@node1 ~]# echo $Linux

[root@node1 ~]# Linux=7.2  
[root@node1 ~]# system="CentOS $Linux"
[root@node1 ~]# echo $system
CentOS 7.2
[root@node1 ~]# system="CentOS$Linux"
[root@node1 ~]# echo $system
CentOS7.2

#单引号 ‘’
#当要赋值的内容包括"$"、"\"等,具有其他含义的特殊字符时,应使用单引号将其括起来;
#在单引号范围内将无法引用其他的值，任何字符均作为普通字符看待，但赋值 的内容包含单引号时需要使用\’符号进行转义以免冲突.

[root@node1 ~]# uname  
Linux
[root@node1 ~]# uname -r
3.10.0-327.36.3.el7.x86_64
[root@node1 ~]# kernel="3.10 $Linux"
[root@node1 ~]# echo $kernel
3.10 7.2
[root@node1 ~]# kernel='3.10 $Linux'
[root@node1 ~]# echo $kernel
3.10 $Linux

#反撇号 `` 
#在键盘esc的下边的按键。 ~
#反撇号主要使用于命令替换，允许将某个命令的屏幕输出结果赋值给变量。

[root@node1 ~]# pwd
/root
[root@node1 ~]# which pwd
/usr/bin/pwd
[root@node1 ~]# rpm -qf $(which pwd)
coreutils-8.22-15.el7.x86_64
[root@node1 ~]# rpm -q coreutils-8.22-15.el7.x86_64
coreutils-8.22-15.el7.x86_64
[root@node1 ~]# rpm -q `rpm -qf `which pwd``               
rpm: no arguments given for query
which-2.20-7.el7.x86_64
package pwd is not installed
[root@node1 ~]# rpm -q $(rpm -qf $(which pwd))
coreutils-8.22-15.el7.x86_64
#使用反撇号难以在一条命令中实现嵌套命令的操作
[root@node1 ~]# rpm -qf `which pwd`
coreutils-8.22-15.el7.x86_64



QQ：553873742  

