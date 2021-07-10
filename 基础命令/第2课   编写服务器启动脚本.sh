shell高级教程-第2课   编写服务器启动脚本

1、安装部署NginxWEB服务器

安装步骤{
	1.安装依赖包
		[root@node1 ~]# yum -y install zlib-devel pcre-devel
	2.添加系统用户
		[root@node1 ~]# useradd -s /sbin/nologin nginx -M
		[root@node1 ~]# tail -1 /etc/passwd
		(-M 不创建宿主目录;-s  指定登陆的shell环境  /sbin/nologin  禁止登陆)
	3.源码编译安装Nginx
		tar解压./configure配置编译生成makefile文件make install 安装

		[root@node1 ~]# tar zxf nginx-1.11.2.tar.gz -C /usr/src/
		[root@node1 ~]# cd /usr/src/nginx-1.11.2/
		[root@node1 nginx-1.11.2]# ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx  

		参数解释:
		--prefix    #指定安装的位置
		--user     #指定运行的用户
		--group   #指定运行的组
	4.浏览器访问测试
	http://IP
	看到welcome to nginx  字样 OK！
}

2、编写服务启动脚本、
	脚本名称：nginx.sh
	脚本思路：
		1.知道nginx主程序的指令
		2.脚本写完放到/etc/init.d/
			mv nginx.sh /etc/init.d/

		3.创建软连接
			ln -s /usr/local/nginx/sbin/nginx  /usr/bin/

		4.添加系统服务
			chkconfig --add nginx.sh


#!/bin/bash
# This is nginx service script!
# chkconfig: 35 86 12
case $1 in
        start)
                netstat -anlpt | grep nginx  >>/dev/null
                if [ $? -eq 0 ]
                        then
                                echo "nginx server running!"
                        else
                                echo "staring nginx!"
                                nginx
                fi
        ;;
        stop)
                netstat -anlpt | grep nginx  >>/dev/null
                if [ $? -eq 0 ]
                        then
                                echo "stoping nginx server!"
                                nginx -s stop
                                echo "nginx stoping success!"
                        else
                                echo " nginx alreadly stop!"


                fi
        ;;
        check)
                echo "starting nginx configfile check!!!-----"
                echo "++++++"
                nginx -t
                echo "++++++"
        ;;
        restart)
                netstat -anlpt | grep nginx >>/dev/null
#               if [ $? -eq 0 ]
                       #then
                                echo "stoping nginx server!"
                                nginx -s stop
                                echo "nginx stoping success!"

                                echo " nginx starting "
                                nginx
                                echo " nginx starting success!"

                #i
		;;
        status)
                netstat -anlpt | grep nginx
        ;;
        *)
                echo "Unknow Option!"
                echo "Please Use {start|stop|restart|status|check} options!!"
        ;;
esac

               