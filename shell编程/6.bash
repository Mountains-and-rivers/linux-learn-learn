shell 全局变量与局部变量

env 用来显示环境变量
export 用来显示和设置环境变量


[root@node1 shell]# export linux
[root@node1 shell]# bash
[root@node1 shell]# echo $linux
7.2

#父shell
[root@node1 shell]# export WWW=baidu.com
[root@node1 shell]# echo $WWW
baidu.com
[root@node1 shell]# bash
[root@node1 shell]# echo $WWW
baidu.com
#子shell
[root@node1 shell]# export aa=bb
[root@node1 shell]# echo $aa
bb
[root@node1 shell]# exit
exit
[root@node1 shell]# echo $aa
