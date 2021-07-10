shell 中的IF语句

if语句是循环语句中的一种又称为控制语句.
通过制定条件进行判断执行;
只有条成立的时候才会执行相对应的代码，否则不会进行任何操作

#单分支if语句
#
if 条件测试操作
then
		命令序列
fi

单分支的结构非常简单，条件成立就执行then命令序列，条件不成立则fi结束

实例1 判断文件存在
#!/bin/bash
# This is my first if scripts!

#/root/cmd
if [ ! -d /root/cmd ]
        then
                mkdir -p /root/cmd
fi

#输出
#[root@node1 ~]# ll -d /root/cmd/
drwxr-xr-x 2 root root 4096 Jul 30 11:02 /root/cmd/

实例2 系统判断
#!/bin/bash
#this is my scripts!

SYS=`uname`
IPADDR=$(ifconfig eth0 | grep "inet" | awk '{print $2}')
KERNEL=`uname -r`

if [ $SYS == Linux ]
  then
    echo "Your system is : $SYS"
    echo "Your IPADDR is : $IPADDR"
    echo "Your KERNEL is : $KERNEL"
fi


总结：单分支语句功能有限，只能完成基本的系统操作。