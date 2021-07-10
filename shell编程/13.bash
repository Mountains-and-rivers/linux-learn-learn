#实战部分
编写脚本程序用于监视系统服务httpd的运行状态。
要求如下：
当服务状态失败时在"/var/log/httpderr.log"文件中记入日志信息。
自动将状态失败的httpd服务重新启动。若重启httpd服务失败，测尝试重新启动服务器主机。

#安装
#能上网
[root@node1 ~]# ping www.baidu.com
PING www.a.shifen.com (220.181.112.244) 56(84) bytes of data.
64 bytes from 220.181.112.244: icmp_seq=1 ttl=55 time=5.78 ms
64 bytes from 220.181.112.244: icmp_seq=2 ttl=55 time=5.83 ms
64 bytes from 220.181.112.244: icmp_seq=3 ttl=55 time=5.82 ms
64 bytes from 220.181.112.244: icmp_seq=4 ttl=55 time=5.90 ms
^C
--- www.a.shifen.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 5.787/5.837/5.905/0.087 ms
 
[root@node1 ~]# rpm -q httpd   #检查httpd软件包有没有安装
package httpd is not installed
[root@node1 ~]# yum -y install httpd   #通过yum安装httpd

#术语
#httpd ： 网站服务  apache ，nginx  tomcat ；
#端口：tcp 80；
#服务名称： httpd
#centos7  查看服务状态   
[root@node1 ~]# systemctl status httpd   #状态
[root@node1 ~]# systemctl start http    #启动
[root@node1 ~]# systemctl stop httpd    #停止
[root@node1 ~]# systemctl restart httpd  #重启


#编写脚本
#
#!/bin/bash
#This is a httpd status script!
#
systemctl status httpd

if [ $? -eq 0 ]
	then
	    echo "Httpd server is running" 
elif [ $? -ne 0 ]
	then
	  echo "Httpd server running fail. Try to restart" >>/var/log/httperr.log
	  read -p " do restart service(YES/NO) ? " DO
	  echo "Your input is $DO "
	  if [ $DO == YES ]
	  		then
	  			echo " restarting httpd service "
	  			systemctl restart httpd
	  elif [ $DO == NO ]
	  		then	
	  			echo "script stop!"
       else
       		echo "please enter YES/NO "
       fi
fi

#输出

[root@node1 ~]# sh httpd.sh 
Httpd server is running
[root@node1 ~]# systemctl stop httpd         
[root@node1 ~]# sh httpd.sh 
 do restart service(YES/NO) ? YES
Your input is YES 
 restarting httpd service 
[root@node1 ~]# sh httpd.sh 
Httpd server is running
