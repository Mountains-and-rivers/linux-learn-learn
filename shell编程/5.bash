shell 位置变量与预定义变量

$# ： 传递到脚本的参数个数
$* ： 以一个单字符串显示所有向脚本传递的参数。与位置变量不同,此选项参数可超过 9个
$$ ： 脚本运行的当前进程 ID号
$! ： 后台运行的最后一个进程的进程 ID号
$@ ： 与$#相同,但是使用时加引号,并在引号中返回每个参数
$- ： 显示shell使用的当前选项,与 set命令功能相同
$? ： 显示最后命令的退出状态。 0表示没有错误,其他任何值表明有错误。


实例：
[root@node1 shell]# sh 01.sh 1 2
1 + 2 = 3
[root@node1 shell]# cat 01.sh 
#!/bin/bash
#This 

SUM=$(expr $1 + $2)
echo "$1 + $2 = $SUM"



实例2：
#!/bin/sh  
#param.sh  
  
# $0:文件完整路径名  
echo "path of script : $0"   
# 利用basename命令文件路径获取文件名  
echo "name of script : $(basename $0)"  
# $1：参数1  
echo "parameter 1 : $1"  
# $2：参数2  
echo "parameter 2 : $2"  
# $3：参数3  
echo "parameter 3 : $3"  
# $4：参数4  
echo "parameter 4 : $4"  
# $5：参数5  
echo "parameter 5 : $5"  
# $#:传递到脚本的参数个数  
echo "The number of arguments passed : $#"  
# $*:显示所有参数内容i  
echo "Show all arguments : $*"  
# $:脚本当前运行的ID号  
echo "Process ID : $"  
# $?:回传码  
echo "errors : $?"  
