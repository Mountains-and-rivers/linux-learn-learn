shell 条件测试语句

test  
[  ]

1、文件测试
文件测试是指根据给定的路径名称，判断是文件还是目录，判断是具有读写执行的权限，判断文件目录是否存在
常用的选项如下
-d：测试是否为目录（Directory）或目录是否存在
-e：测试目录或文件是否存在（Exist）
-f：测试是否为文件（File）或文件是否存在
-r：测试当前用户是否有权限读取（Read）
-w：测试当前用户是否有权限写入（Write）
-x：测试当前用户是否有权限执行（eXcute）


/media/cdrom 
[root@node1 ~]# ls /media/
[root@node1 ~]# [ -d /media/cdrom ] 
[root@node1 ~]# echo $?
1
[root@node1 ~]# [ ! -d /media/cdrom ] 
[root@node1 ~]# echo $?
0


[root@node1 ~]# [ ! -d /media/cdrom ] && mkdir -p /media/cdrom 
[root@node1 ~]# ls /media/cdrom

[root@node1 ~]# [ ! -d /media/cdrom ]  && echo " File ok "
[root@node1 ~]# [ -d /media/cdrom ]  && echo " File ok "
 File ok 


[root@node1 ~]# test -d /media/cdrom/
[root@node1 ~]# echo $?
0


#多条件判断
#
#逻辑测试
逻辑测试指得是判断两个或多个条件之间的依赖关系，当系统取决于多个条件时，
根据这些条件或其中的一个条件成立等情况的过程，
常用的逻辑测试
&&：逻辑与，“并且而且”的意思    满足两个条件
||：逻辑或，“或者”的意思       满足两个条件中的一个
!：逻辑否       


[root@node1 ~]# ll first.sh 
-rwxr-xr-x 1 root root 82 Jul 29 15:16 first.sh
[root@node1 ~]# test -x first.sh 
[root@node1 ~]# echo $?
0


[root@node1 ~]# A=10
[root@node1 ~]# [ $A -gt 1 ] && echo yes
yes
[root@node1 ~]# [ $A -gt 1 ] || echo yes
[root@node1 ~]# [ ! $A -gt 1 ] || echo yes
yes


#数值比较
#
#数值的比较指的是根据给定的两个整数判断第一个数值与第二个数值的关系
-eq：等于（Equal）  Eq
-ne：不等于（Not Equal）  
-gt：大于（Greater Than）
-lt：小于（Lesser Than）                 
-le：小于或等于（Lesser or Equal）
-ge：大于或等于（Greater or Equal）
格式 [ 数值1 操作符 数值2  ]

#判断当前登录的用户数
#
[root@node1 ~]# users=$(who | wc -l)
[root@node1 ~]# echo $users
1
[root@node1 ~]# [ $users -gt 5 ] && echo $users
[root@node1 ~]# [ ! $users -gt 5 ] && echo $users
1
[root@node1 ~]# [ $users -gt 1 ] && echo $users
[root@node1 ~]# [ $users -eq 1 ] && echo $users
1
[root@node1 ~]# [ $users -lt 1 ] && echo $users
[root@node1 ~]# [ $users -lt 5 ] && echo $users
1

#字符串比较
#
字符串比较通常用来检查用户输入、系统环境是否满足条件、在提供交互式操作的shell脚本中也可以判断用户输入位置参数是否符合要求，字符串的常用操作如下
=  字符串内容相同
!= 字符串内容不同
 -z 字符串内容为空

实例1：判断当前的字符集
#!/bin/bash
#

echo $LANG
[ $LANG != en.US ] && echo "$LANG"
[ $LANG = en.US ] && echo "$LANG"


#输出
[root@node1 ~]# vim lang.sh 
[root@node1 ~]# sh -x lang.sh 
+ echo C
C
+ '[' C '!=' en.US ']'
+ echo C
C
+ '[' C = en.US ']'
[root@node1 ~]# sh lang.sh 
C
C
[root@node1 ~]# echo $LANG
C


实例2：判断字符串是否为空

[root@node1 ~]# a= 
[root@node1 ~]# echo $a

[root@node1 ~]# [ $a -z ] && echo "ok ! "
ok ! 
[root@node1 ~]# [ ! $a -z ] && echo "ok ! "
[root@node1 ~]# [ ! $a -z ] || echo "ok ! "
ok !