03-shell 变量

变量的定义是：可以存放一个可变的值的空间，可以通过不同的环境进行改变就是一个可以变的值.默认情况下: 在Linux中可以将每个shell看成不同的执行环境,所以相同的一个变量名称在不同的变量执行环境中的变量值是不同的.

1.1 变量格式
	变量名称 = 变量值 
	变量名称不可以以数字、特使字符开头；
	“=”  为变量赋值；
	变量的值可以是（数字  字符串 文件的位置 命令 命令的结果）

1.2 shell变量的分类
	自定义变量、环境变量、位置变量、预定义变量；

1.3 变量的输出
	a=1
	echo $a
	echo 输出变量,注意变量名前添加$符号；
-----------------------------------------------------------------

2、自定义变量
	例1：
		[root@node1 ~]# Linux=7.2
		[root@node1 ~]# echo $Linux
		7.2
		[root@node1 ~]# linux=6.5
		[root@node1 ~]# echo $linux
		6.5
		[root@node1 ~]# echo $Linux
		7.2
 	结论：echo和调用的变量之间必须要有空格，注意大小写的变量的值是不同的。
   
    例2：调用多组变量
    	[root@node1 ~]# system=centos
		[root@node1 ~]# version=7.2
		[root@node1 ~]# echo $system $version
		centos 7.2
		[root@node1 ~]# echo sys{$Linux}
		sys{7.2}
		[root@node1 ~]# echo sys$Linux 
		sys7.2

	结论：直接通过echo  变量名即可

