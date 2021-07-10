11-Shell编程-双分支IF语句


双分支的选择结果，要求针对条件成立，条件不成立两种情况分别执行不同的操作.

语法结构

if 条件测试操作
then（条件成立执行）	
		命令序列1
else（否则,条件不成立,则执行）
	 	命令序列2
fi

首先通过if进行条件测试。如果条件成立则执行命令序列1如果不成立则进行命令序列2之后fi结束判断

实例1：测试主机存活
脚本解释：如果if判断为0则接下来执行then输出目标主机up
如果不为0则执行else输出目标主机down
#!/bin/bash
#

ping -c 3 -i 0.2 -w 3 $1 >/dev/null

if [ $? -eq 0 ]
  then
    echo "$1 is up ! " 
  else
    echo "Targethost is down ! "
fi

#输出
[root@node1 ~]# sh if03.sh 127.0.0.1
127.0.0.1 is up ! 

扩展：ping
-c ping包的次数 
-i ping包的间隔
-w 超时的时间间隔

实例2
#!/bin/bash
#
STR=98

read -p "Please enter your number !" num
echo "You enter num is : $num"

if [ $num == $STR ]
  then
    echo "GOOD,you guess it!"
  else
    echo "Sorry,you are lose !"
fi

#输出
[root@node1 ~]# sh if04.sh 
Please enter your number !20
You enter num is : 20
Sorry,you are lose !


双分支的优势 --- 成立执行成立的操作,不成立则执行不成立的操作;