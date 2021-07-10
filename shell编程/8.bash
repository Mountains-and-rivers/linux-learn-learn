shell 交互式赋值

read命令 
read命令用来提示用户输入信息，从而实现简单的交互式过程


[root@node1 ~]# read kernel
12
[root@node1 ~]# echo $kernel
12
[root@node1 ~]# read a b c
1 2 3
[root@node1 ~]# echo $a $b $c
1 2 3

#-p 提示信息
[root@node1 ~]# read -p "Please enter your password:" password
Please enter your password:123
[root@node1 ~]# echo $password 
123

[root@node1 ~]# read -p "Please enter your name ! " name
Please enter your name ! jack
[root@node1 ~]# echo $name
jack


实例1：身份验证
判断用户名是root 密码是123456  成功登陆；
否则提示账号或密码错误！ 

#!/bin/bash
#This is a scripts!

#user=root
read -p "Please enter your UserName : " name
echo "Your UserName is : $name"
if [ $name == root ]
  then
    read -p "Please enter your Password : " passwd
    if [ $passwd == 123456 ]
      then
        echo "Good! Success! "
    else
        echo "Username or Password error!"
    fi
fi

#输出
#[root@node1 ~]# sh user.sh 
Please enter your UserName : root
Your UserName is : root
Please enter your Password : 123456
Good! Success! 

[root@node1 ~]# sh user.sh 
Please enter your UserName : root
Your UserName is : root
Please enter your Password : 123
Username or Password error!