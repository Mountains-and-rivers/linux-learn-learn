第6课  shell编程之函数

1、函数的定义

function 函数名(){
	commands
	[return]
}


name(){
	commands
	[return]
}

#注释
function :关键字定义函数，可省略。
{}：表示函数体的开始：函数体。
commands： 可以是任意的shell命令。

exit命令退出整个脚本；
break 语句中断函数执行；

命令：
declare -f 显示定义的函数清单 
declare -F 显示定义的函数名称
unset -f  从shell内存中删除函数
export -f  将函数输出给shell

#定义函数
[root@node1 ~]# cat func1.sh 
#!/bin/bash

hello(){
	echo "Hello World!"
}

————————————————————————————————————————————————
2、函数的调用
	2.1定义函数文件func1.sh
	2.2在脚本中使用source生效函数文件

#func1文件内容
[root@node1 ~]# cat func1.sh 
#!/bin/bash

hello(){
	echo "Hello World!"
}

#func2文件内容
[root@node1 ~]# cat func2.sh 
#!/bin/bash
source /root/func1.sh
hello
————————————————————————————————————————————————

3.函数的参数传递
	函数也可以通过位置变量传递参数
	函数名称 参数1 参数2 参数3 参数4

	[root@node1 ~]# cat func1.sh 
	#!/bin/bash

	hello(){
		echo "Hello World!,$1"
	}
	hello lisi
	hello zhangsan

	#执行结果
	[root@node1 ~]# sh func1.sh 
	Hello World!,lisi
	Hello World!,zhangsan
————————————————————————————————————————————————

4.函数的返回值
return 返回函数值，范围0~256 ，也可通过$？获取。
#内容
[root@node1 ~]# cat func1.sh 
#!/bin/bash

hello(){
	echo "Hello World!,$1"
	return 222
}
hello lisi
hello zhangsan

#输出
[root@node1 ~]# sh func1.sh 
Hello World!,lisi
Hello World!,zhangsan
[root@node1 ~]# echo $?
222

————————————————————————————————————————————————
5.函数的加载
source 生效函数/加载函数。

删除
#unset -f 函数名


实例
[root@node1 ~]# touch /etc/a.txt
[root@node1 ~]# vim func3.sh
[root@node1 ~]# source func3.sh 
[root@node1 ~]# delete /etc/a.txt /home/docker
[root@node1 ~]# echo $?
0
[root@node1 ~]# ll /etc/a.txt
ls: cannot access /etc/a.txt: No such file or directory
[root@node1 ~]# ll /home/docker/
total 0


#脚本内容
delete(){
        rm -fr $1
        mkdir -p $2
}