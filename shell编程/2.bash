脚本的执行
1、解释器执行
	格式：解释器 脚本

2、相对路径执行（需要添加执行权限）
	[root@node1 ~]# chmod +x first.sh 
	[root@node1 ~]# ./first.sh 
	Hello World!
3、绝对路径执行（需要添加执行权限）
	[root@node1 ~]# chmod o+x first.sh 
	[root@node1 ~]# pwd
	/root
	[root@node1 ~]# /root/first.sh 
	Hello World!
4、通过脚本名执行 
	[root@node1 ~]# . first.sh 
	Hello World!

5、通过source
	[root@node1 ~]# source first.sh 
	Hello World!

总结： 在生产环境中，最好使用不加权限的方式执行；
----------------------------------------------------
扩展内容：

1.1 解释器{

[root@node1 ~]# cat /etc/shells 
/bin/sh
/bin/bash
/sbin/nologin
/usr/bin/sh
/usr/bin/bash
/usr/sbin/nologin
/bin/tcsh
/bin/csh

}

1.2 Linux中权限
ll 查看文件的详细信息等同于ls -l
[root@node1 ~]# ll first.sh 
-rw-r--r-- 1 root root 82 Jul 29 15:16 first.sh

#权限{
	r=read  读取
	w=write	写入
	x=run	执行
	#权限位组成{
		文件的属性（d -）；
		属主的权限；
		属组的权限；
		其他人的权限：
	}

}         
属主（文件的拥有者）
属组 （文件的拥有组）

1.3 权限修改{
	chmod 命令
	格式： chmod [u,g,o] [+-=] [rwx]  file
'''
[root@node1 ~]# ll first.sh 
-rw-r--r-- 1 root root 82 Jul 29 15:16 first.sh
[root@node1 ~]# chmod u+x first.sh 
[root@node1 ~]# ll first.sh 
-rwxr--r-- 1 root root 82 Jul 29 15:16 first.sh
[root@node1 ~]# chmod u-x first.sh 
[root@node1 ~]# ll first.sh 
-rw-r--r-- 1 root root 82 Jul 29 15:16 first.sh
[root@node1 ~]# chmod +x first.sh 
[root@node1 ~]# ll first.sh 
-rwxr-xr-x 1 root root 82 Jul 29 15:16 first.sh
'''

}