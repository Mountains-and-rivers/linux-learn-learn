shell 基础命令
（系统管理与维护）

命令{
	ls 命令{
		查看文件目录
		选项： -a 显示隐藏文件   -d 查看目录属性  -l 文件的详细信息
		实例：{
			[root@node1 ~]# cd /home/
			[root@node1 home]# ls
			mysql.sql  select.sql  view.sql
			[root@node1 home]# ls -a
			.  ..  mysql.sql  select.sql  view.sql
			[root@node1 home]# touch .a.txt
			[root@node1 home]# ls
			mysql.sql  select.sql  view.sql
			[root@node1 home]# ls -a 
			.  ..  .a.txt  mysql.sql  select.sql  view.sql

			[root@node1 home]# mkdir shell
			[root@node1 home]# ls -d shell/
			shell/
			[root@node1 home]# ls -d shell/ -l
			drwxr-xr-x 2 root root 4096 Aug  5 09:45 shell/

			[root@node1 ~]# ls -l a.txt 
			-rw-r--r-- 1 root root 9 Jul 30 14:23 a.txt
			[root@node1 ~]# ll a.txt 
			-rw-r--r-- 1 root root 9 Jul 30 14:23 a.txt
	    }
	}

	pwd{
		作用：查看当前的工作位置。
		实例：{
			[root@node1 ~]# pwd
			/root
			[root@node1 ~]# echo $PWD
			/root
			[root@node1 ~]# cd /home/
		}

	}

	cd{
		作用：切换目录
		选项 ： cd - 返回上个位置 ，  cd . 返回当前目录，cd .. 返回上级目录。
		实例：{
			[root@node1 home]# cd /dev/
			[root@node1 dev]# cd -
			/home
			[root@node1 home]# cd .
			[root@node1 home]# cd ./shell/
			[root@node1 shell]# cd ..
			[root@node1 ~]# cd /home/
			[root@node1 home]# cd ~
			[root@node1 ~]# 
		}

	}

	date {
		作用：显示或设置当前的时间；
		选项：%Y-%m-%d %H:%M:%S   -s 设置时间
		实例：{
			[root@node1 ~]# date +%Y
			2017
			[root@node1 ~]# date +%Y-%m
			2017-08
			[root@node1 ~]# date +%Y-%m-%d
			2017-08-05
			[root@node1 ~]# date +%Y-%m-%d %H
			date: extra operand '%H'
			Try 'date --help' for more information.
			[root@node1 ~]# date "+%Y-%m-%d %H"
			2017-08-05 09
			[root@node1 ~]# date "+%Y-%m-%d %H:%M"
			2017-08-05 09:55
			[root@node1 ~]# date "+%Y-%m-%d %H:%M:%s"
			2017-08-05 09:55:1501898138
			[root@node1 ~]# date "+%Y-%m-%d %H:%M:%S"
			2017-08-05 09:55:43
			#时间修改
			[root@node1 ~]# date 
			Sat Aug  5 09:56:19 CST 2017
			[root@node1 ~]# date -s 20:22
			Sat Aug  5 20:22:00 CST 2017
			[root@node1 ~]# date
			Sat Aug  5 20:22:03 CST 2017
			[root@node1 ~]# date -s "2022-10-09 20:22"
			Sun Oct  9 20:22:00 CST 2022

		}

	}

	passwd{
		作用：修改用户的密码。
		实例：{
			[root@node1 ~]# passwd nginx
			Changing password for user nginx.
			New password: 
			BAD PASSWORD: The password is shorter than 8 characters
			Retype new password: 
			passwd: all authentication tokens updated successfully.
		}
	}

	su{
		作用：切换用户
		格式： su 用户名 ，su - nginx 同环境变量一起切换到nginx。
	}


	clear{
		作用：清屏
	}

	man{
		作用： 查看命令的信息；

	}
}