17-Shell编程 while 循环语句

while循环的语法结构

while 条件测试

do
	命令序列

done

//使用while循环语句时，可以根据特定的条件反复执行一个命令，直到条件不满足为止
//while会出现死循环的过程，因此循环体内的命令序列内应包括修改测试条件的语句;



实例：
批量添加用户

要求 ： stu 20个用户  stu1-stu20
脚本内容{
	#!/bin/bash
	#
	user="stu"
	i=1

	while [ $i -le 20 ]

	do
		useradd ${user}$i
		echo "123456" | passwd --stdin ${user}$i >>/dev/null
		let i++
	done

}

删除{
	#!/bin/bash
	#
	user="stu"
	i=1

	while [ $i -le 20 ]

	do
		userdel -r ${user}$i >>/dev/null
		echo "${user}$i TO DELETE SUCCESS!"
		let i++
	done

}


实例：输出1=10 数字

#!/bin/bash
#
myvar=1
while [ $myvar -le 10 ]
do
	echo $myvar
	myvar=$(($myvar + 1))
done


实战编写猜价格游戏

1、生成0~999 之间的数字

脚本内容

#!/bin/bash
#
price=$(expr $RANDOM % 1000)
times=0

echo "The prices of the goods is 0~999,Can you guess what is ?"

while true
do
	read -p "Please enter your price:" INT
	echo "YOUR price is $INT"
	let time++
	if [  $INT -eq $price ]
		then
		echo "Good YOU Guess it"
		echo "You Guess the total $time times"
		exit 0
		elif [ $INT -gt $price ]
			then
			echo "Is too high"
		else
			echo "Is too low"
	fi
done


[root@node1 ~]# sh w3.sh 
The prices of the goods is 0~999,Can you guess what is ?
Please enter your price:500
YOUR price is 500
Is too high
Please enter your price:200
YOUR price is 200
Is too high
Please enter your price:100
YOUR price is 100
Is too low
Please enter your price:150
YOUR price is 150
Is too high
Please enter your price:125
YOUR price is 125
Is too low
Please enter your price:140
YOUR price is 140
Is too low
Please enter your price:148
YOUR price is 148
Is too high
Please enter your price:145 
YOUR price is 145
Is too low
Please enter your price:146
YOUR price is 146
Good YOU Guess it
You Guess the total 9 times