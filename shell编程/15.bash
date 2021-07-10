shell 基础命令

who{
	作用：查看当前的登录到系统的用户；

	实例：{
	root     pts/0        Aug  5 09:38 (111.132.86.128)
	名称：当前的用户。
	终端：当前所在的终端。
	时间：登录的时间。
	主机名：主机名或者IP地址。


		[root@node1 ~]# who -a   #列出所有信息
		           system boot  Jun  7 20:52
		           run-level 3  Jun  7 20:53
		LOGIN      ttyS0        Jun  7 20:53              5350 id=tyS0
		LOGIN      tty1         Jun  7 20:53              5349 id=tty1
		root     + pts/0        Aug  5 09:38  old         9746 (111.132.86.128)
		           pts/1        Jun 18 21:52             17962 id=ts/1  term=0 exit=0
		nginx    + pts/2        Aug  5 11:06   .         14090 (111.132.86.128)
		[root@node1 ~]# who -b  #列出系统最近启动的时间
		         system boot  Jun  7 20:52
		[root@node1 ~]# who -l  #列出所有登录的终端信息
		LOGIN    ttyS0        Jun  7 20:53              5350 id=tyS0
		LOGIN    tty1         Jun  7 20:53              5349 id=tty1
		[root@node1 ~]# who -m  #显示关于终端的当前信息
		root     pts/0        Aug  5 09:38 (111.132.86.128)
		[root@node1 ~]# who am i  #与who -m 类似
		root     pts/0        Aug  5 09:38 (111.132.86.128)
		[root@node1 ~]# who -r    #查看当前系统运行级别
		run-level 3  Jun  7 20:53

	}
}

w{
	作用：显示登录到系统的用户。
	选项：-h不显示输出信息的标题 -l 用长格式输出； -s 短格式输出； -V显示版本
	实例：{
		[root@node1 ~]# w
		 11:12:22 up 58 days, 14:18,  2 users,  load average: 0.00, 0.01, 0.05
		USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
		root     pts/0    111.132.86.128   09:38     ?     0.10s  0.00s w
		nginx    pts/2    111.132.86.128   11:06    5:42   0.03s  0.03s -bash

		#注释
		系统时间  系统运行总时间  当前登录的用户  系统负载 1分钟 5分钟 15分钟

	}
}


uname{
	作用：显示系统的相关信息
	选项：
		-n 显示主机名称
		-a 显示系统的全部信息
		-m 显示系统CPU信息，类型32/64
		-s 显示操作系统类型
		-r 显示内核版本
	实例：{

		[root@node1 ~]# uname
		Linux
		[root@node1 ~]# uname -r
		3.10.0-327.36.3.el7.x86_64
		[root@node1 ~]# uname -a
		Linux node1 3.10.0-327.36.3.el7.x86_64 #1 SMP Mon Oct 24 16:09:20 UTC 2016 x86_64 x86
		_64 x86_64 GNU/Linux
		[root@node1 ~]# uname -m 
		x86_64
		[root@node1 ~]# uname -n
		node1
		[root@node1 ~]# uname -s
		Linux

	}
}

uptime{
	作用：输出系统的任务队列信息；
	实例：{
		[root@node1 ~]# uptime
 		11:24:49 up 58 days, 14:30,  2 users,  load average: 0.00, 0.01, 0.05
		#注释
		系统时间  系统运行总时间  当前登录的用户  系统负载 1分钟 5分钟 15分钟

}


last{
	作用：所有登入系统的用户相关信息，/var/log/wtmp
	选项：
		-a 吧从何处登录的主机和用户名显示在最后一行；
		-R 不输出主机名和IP地址
		-x 显示系统开关机等信息
		-n 列出名单的显示列数
		-d 将显示的IP地址转换成主机名称

	实例：{

		[root@node1 ~]# last -a
		nginx    pts/2        Sat Aug  5 11:30   still logged in    111.132.86.128

		wtmp begins Sat Aug  5 11:30:09 2017
		[root@node1 ~]# last -R
		nginx    pts/2        Sat Aug  5 11:30   still logged in   

		wtmp begins Sat Aug  5 11:30:09 2017
		[root@node1 ~]# last -xx
		nginx    pts/2        111.132.86.128   Sat Aug  5 11:30   still logged in   

		wtmp begins Sat Aug  5 11:30:09 2017
		[root@node1 ~]# last -x 
		nginx    pts/2        111.132.86.128   Sat Aug  5 11:30   still logged in   

		wtmp begins Sat Aug  5 11:30:09 2017
		[root@node1 ~]# last -2
		nginx    pts/2        111.132.86.128   Sat Aug  5 11:30   still logged in   

		wtmp begins Sat Aug  5 11:30:09 2017
		[root@node1 ~]# last -1
		nginx    pts/2        111.132.86.128   Sat Aug  5 11:30   still logged in
			}
}


dmesg{
	作用：显示系统开机信息
}

free{
	作用：显示内存的信息
	选项：
		-b 以字节为单位显示内存的使用量
		-m 以M为单位显示内存的使用量
		-g 以g为单位显示内存的使用量

	实例{
		[root@node1 ~]# free 
              total        used        free      shared  buff/cache   available
		Mem:        1016904      138312       73084       12820      805508      682032
		Swap:             0           0           0
		[root@node1 ~]# free -m
		              total        used        free      shared  buff/cache   available
		Mem:            993         135          71          12         786         666
		Swap:             0           0           0
		[root@node1 ~]# free -g
		              total        used        free      shared  buff/cache   available
		Mem:              0           0           0           0           0           0
		Swap:             0           0           0
		[root@node1 ~]# free -b
		              total        used        free      shared  buff/cache   available
		Mem:     1041309696   141631488    74838016    13127680   824840192   698400768
		Swap:             0           0           0

	}
}

ps{
	作用：查询进程信息
	选项：
		-a 显示所有用户的进程
		-x  显示所有系统中的程序
		-u 显示使用者的时间和名称
		-f 显示详细的程序执行路径信息
		-c 只显示进程的名称

	实例：{

		[root@node1 ~]# ps aux | grep httpd
		[root@node1 ~]# ps aux | grep httpd | grep -v grep


	}
}

top{
	作用：动态查看进程
	选项：
		-d 指定屏幕刷新时间间隔
		-i 不显示闲置或者是僵尸进程
		-c 显示进程的整个路径
		-s 在安全模式运行
		-b 分屏显示输出
		-n 输出信息的更新次数
	实例：{
		#top
		PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                      
   		 1 root      20   0  125116   3048   1800 S  0.0  0.3  14:41.24 systemd  

   		
   		# 第七行以下：各进程（任务）的状态监控
		PID — 进程id
		USER — 进程所有者
		PR — 进程优先级
		NI — nice值。负值表示高优先级，正值表示低优先级
		VIRT — 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
		RES — 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
		SHR — 共享内存大小，单位kb
		S — 进程状态。D=睡眠状态 R=运行 S=睡眠 T=跟踪/停止 Z=僵尸进程
		%CPU — 上次更新到现在的CPU时间占用百分比
		%MEM — 进程使用的物理内存百分比
		TIME+ — 进程使用的CPU时间总计，单位1/100秒
		COMMAND — 进程名称（命令名/命令行）
	}

	快捷键：{
		i 过滤闲置和僵尸进程
		m 显示内存信息
		M 以mem排序
		P 以CPU占用排序

	}

}

