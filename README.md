# linux-学习

学习链接：http://v.xue.taobao.com/learn.htm?courseId=74059 

### find 命令

语法： find     搜索目录位置 参数  搜索条件

-name： 按名称搜索

    find  /  -name "for*.sh"
    find  /  -name ?1
    find /run -type 's'

-type: 按类型搜索

find / -type  f/d/l/b/c/s/p

```
find ./ -type 'f'
```

-size:  按大小搜索

```
find / -size 1000 #默认单位是512b
find / -size +1M -size -5M #M必须大写
find / -size +1k -size -5k #k必须大写
```

-maxdepth：指定搜索层级深入度。放置于其他参数之前

```
find ./ -maxdepth 1 -type 'f'
find ./ -maxdepth 1 -type 'f' -and -name "*.cap"
find ./ -maxdepth 1 -type 'f' -or -name "*.cap"
find ./ -maxdepth 1 -type 'f'|ls
find ./ -maxdepth 1 -type 'f' -exec ls -l {} \; # ls 是{}的参数，touch adb\ axy

```

-xargs: 对搜索文件执行命令

```
touch adb\ axy
find ./ -maxdepth 1 -type 'f' | xargs ls -l #同上
find ./ -maxdepth 1 -type 'f' -print0 | xargs -0 ls -l

和 exec的区别： exec 可以搜索到文件 adb\ axy
而xargs 需要携程 -print0 | xargs -0的形式
```

### grep命令

grep -r/R 递归搜索文件路径

```
grep -r "love" /

find ./ -maxdepth 1 -type 'f' -print0 |xargs -0  grep "love"
find ./ -maxdepth 1 -type 'f' -print0 |xargs -0  grep "love" -h #内容
输出: ”my love
fnd ./ -maxdepth 1 -type 'f' -print0 |xargs -0  grep "love" -i #文件+ 内容
输出：./adb axy:my love
find ./ -maxdepth 1 -type 'f' -print0 |xargs -0  grep "love" -n #文件+ 行号 + 内容
输出：./adb axy:4:my love
```

### awk命令

一：简介

```
awk 是一种编程语言，用于在 linux/unix 下对文本和数据进行处理。数据可以来自标准输入、
一个或多个文件，或其它命令的输出。它支持用户自定义函数和动态正则表达式等先进功能，是
linux/unix下的一个强大编程工具。它在命令行中使用，但更多是作为脚本来使用。awk 的处理文本和数据的方式是这样的，它逐行扫描文件，从第一行到最后一行，寻找匹配的特定模式的行，并在这些行上进行你想要的操作。如果没有指定处理动作，则把匹配的行显示到标准输出(屏幕)，如果没有指定模式，则所有被操作所指定的行都被处理。awk 分别代表其作者姓氏的第一个字母。因为它的作者是三个人，分别是 Alfred Aho、Brian Kernighan、Peter Weinberger。gawk是 awk 的GNU 版本，它提供了 Bell 实验室和 GNU 的一些扩展。
```

二：语法格式

```
awk [options] 'commands' filenames
awk [options] -f awk-script-file filenames
```

＝＝options：
-F 定义输入字段分隔符，默认的分隔符是空格或制表符(tab)

```
awk -F":" '{print $1}' /etc/passwd
awk -F"x" '{print $1}' /etc/passwd
```

＝＝command：
BEGIN{} {} END{}
行处理前 行处理 行处理后

```
awk -F":" 'BEGIN{print 2/5}' #BEGIN发生在读取文件之前，没有文件也执行
awk 'BEGIN{print 2/5} {print "ok"} END{print "----------"}' /etc/hosts
0.4
ok
ok
----------
说明：END在行处理之后。{print "ok"} 是行处理，/etc/hosts有2行
BEGIN 通常定义一些变量，在行处理之前。
例如：
awk 'BEGIN{FS=":"} {print $1,$2} END{print "----------"}' /etc/passwd # FS 定义字段分隔符
 awk 'BEGIN{FS=":";OFS="----"} {print $1,$2}' /etc/passwd

```

＝＝awk 命令格式：

```
awk 'pattern' filename 示例：awk -F: '/root/' /etc/passwd
awk '{action}' filename 示例：awk -F: '{print $1}' /etc/passwd
awk 'pattern {action}' filename 示例：awk -F: '/root/{print $1,$3}' /etc/passwd /root/ 是正则匹配
示例：awk 'BEGIN{FS=":"} /root/{print $1,$3}' /etc/passwd
command |awk 'pattern {action}' 示例：df -P| grep '/' |awk '$4 > 25000 {print $4}'
```

详情

```
awk是行处理器: 相比较屏幕处理的优点，在处理庞大文件时不会出现内存溢出或是处理缓慢的问题，通常用来格式化文本信息
awk处理过程: 依次对每一行进行处理，然后输出
awk命令形式:
awk [-F|-f|-v] ‘BEGIN{} //{command1; command2} END{}’ file
 [-F|-f|-v]   大参数，-F指定分隔符，-f调用脚本，-v定义变量 var=value
'  '          引用代码块
BEGIN   初始化代码块，在对每一行进行处理之前，初始化代码，主要是引用全局变量，设置FS分隔符
//           匹配代码块，可以是字符串或正则表达式
{}           命令代码块，包含一条或多条命令
；          多条命令使用分号分隔
END      结尾代码块，在对每一行进行处理之后再执行的代码块，主要是进行最终计算或输出结尾摘要信息
 
特殊要点:
$0           表示整个当前行
$1           每行第一个字段
NF          字段数量变量
NR          每行的记录号，多文件记录递增
FNR        与NR类似，不过多文件记录不递增，每个文件都从1开始
\t            制表符
\n           换行符
FS          BEGIN时定义分隔符
RS       输入的记录分隔符， 默认为换行符(即文本是按一行一行输入)
~            匹配，与==相比不是精确比较
!~           不匹配，不精确比较
==         等于，必须全部相等，精确比较
!=           不等于，精确比较
&&　     逻辑与
||             逻辑或
+            匹配时表示1个或1个以上
/[0-9][0-9]+/   两个或两个以上数字
/[0-9][0-9]*/    一个或一个以上数字
FILENAME 文件名
OFS      输出字段分隔符， 默认也是空格，可以改为制表符等
ORS        输出的记录分隔符，默认为换行符,即处理结果也是一行一行输出到屏幕
-F'[:#/]'   定义三个分隔符
 
print & $0
print 是awk打印指定内容的主要命令
awk '{print}'  /etc/passwd   ==   awk '{print $0}'  /etc/passwd  
awk '{print " "}' /etc/passwd                                           //不输出passwd的内容，而是输出相同个数的空行，进一步解释了awk是一行一行处理文本
awk '{print "a"}'   /etc/passwd                                        //输出相同个数的a行，一行只有一个a字母
awk -F":" '{print $1}'  /etc/passwd 
awk -F: '{print $1; print $2}'   /etc/passwd                   //将每一行的前二个字段，分行输出，进一步理解一行一行处理文本
awk  -F: '{print $1,$3,$6}' OFS="\t" /etc/passwd        //输出字段1,3,6，以制表符作为分隔符
 
-f指定脚本文件
awk -f script.awk  file
BEGIN{
FS=":"
}
{print $1}               //效果与awk -F":" '{print $1}'相同,只是分隔符使用FS在代码自身中指定
 
awk 'BEGIN{X=0} /^$/{ X+=1 } END{print "I find",X,"blank lines."}' test 
I find 4 blank lines.
 ls -l|awk 'BEGIN{sum=0} !/^d/{sum+=$5} END{print "total size is",sum}'                    //计算文件大小
total size is 17487
 
-F指定分隔符
$1 指指定分隔符后，第一个字段，$3第三个字段， \t是制表符
一个或多个连续的空格或制表符看做一个定界符，即多个空格看做一个空格
awk -F":" '{print $1}'  /etc/passwd
awk -F":" '{print $1 $3}'  /etc/passwd                       //$1与$3相连输出，不分隔
awk -F":" '{print $1,$3}'  /etc/passwd                       //多了一个逗号，$1与$3使用空格分隔
awk -F":" '{print $1 " " $3}'  /etc/passwd                  //$1与$3之间手动添加空格分隔
awk -F":" '{print "Username:" $1 "\t\t Uid:" $3 }' /etc/passwd       //自定义输出  
awk -F: '{print NF}' /etc/passwd                                //显示每行有多少字段
awk -F: '{print $NF}' /etc/passwd                              //将每行第NF个字段的值打印出来
 awk -F: 'NF==4 {print }' /etc/passwd                       //显示只有4个字段的行
awk -F: 'NF>2{print $0}' /etc/passwd                       //显示每行字段数量大于2的行
awk '{print NR,$0}' /etc/passwd                                 //输出每行的行号
awk -F: '{print NR,NF,$NF,"\t",$0}' /etc/passwd      //依次打印行号，字段数，最后字段值，制表符，每行内容
awk -F: 'NR==5{print}'  /etc/passwd                         //显示第5行
awk -F: 'NR==5 || NR==6{print}'  /etc/passwd       //显示第5行和第6行
route -n|awk 'NR!=1{print}'                                       //不显示第一行
 
//匹配代码块
//纯字符匹配   !//纯字符不匹配   ~//字段值匹配    !~//字段值不匹配   ~/a1|a2/字段值匹配a1或a2   
awk '/mysql/' /etc/passwd
awk '/mysql/{print }' /etc/passwd
awk '/mysql/{print $0}' /etc/passwd                   //三条指令结果一样
awk '!/mysql/{print $0}' /etc/passwd                  //输出不匹配mysql的行
awk '/mysql|mail/{print}' /etc/passwd
awk '!/mysql|mail/{print}' /etc/passwd
awk -F: '/mail/,/mysql/{print}' /etc/passwd         //区间匹配
awk '/[2][7][7]*/{print $0}' /etc/passwd               //匹配包含27为数字开头的行，如27，277，2777...
awk -F: '$1~/mail/{print $1}' /etc/passwd           //$1匹配指定内容才显示
awk -F: '{if($1~/mail/) print $1}' /etc/passwd     //与上面相同
awk -F: '$1!~/mail/{print $1}' /etc/passwd          //不匹配
awk -F: '$1!~/mail|mysql/{print $1}' /etc/passwd        
 
IF语句
必须用在{}中，且比较内容用()扩起来
awk -F: '{if($1~/mail/) print $1}' /etc/passwd                                       //简写
awk -F: '{if($1~/mail/) {print $1}}'  /etc/passwd                                   //全写
awk -F: '{if($1~/mail/) {print $1} else {print $2}}' /etc/passwd            //if...else...
 
 
条件表达式
==   !=   >   >=  
awk -F":" '$1=="mysql"{print $3}' /etc/passwd  
awk -F":" '{if($1=="mysql") print $3}' /etc/passwd          //与上面相同 
awk -F":" '$1!="mysql"{print $3}' /etc/passwd                 //不等于
awk -F":" '$3>1000{print $3}' /etc/passwd                      //大于
awk -F":" '$3>=100{print $3}' /etc/passwd                     //大于等于
awk -F":" '$3<1{print $3}' /etc/passwd                            //小于
awk -F":" '$3<=1{print $3}' /etc/passwd                         //小于等于
 
逻辑运算符
&&　|| 
awk -F: '$1~/mail/ && $3>8 {print }' /etc/passwd         //逻辑与，$1匹配mail，并且$3>8
awk -F: '{if($1~/mail/ && $3>8) print }' /etc/passwd
awk -F: '$1~/mail/ || $3>1000 {print }' /etc/passwd       //逻辑或
awk -F: '{if($1~/mail/ || $3>1000) print }' /etc/passwd 
 
数值运算
awk -F: '$3 > 100' /etc/passwd    
awk -F: '$3 > 100 || $3 < 5' /etc/passwd  
awk -F: '$3+$4 > 200' /etc/passwd
awk -F: '/mysql|mail/{print $3+10}' /etc/passwd                    //第三个字段加10打印 
awk -F: '/mysql/{print $3-$4}' /etc/passwd                             //减法
awk -F: '/mysql/{print $3*$4}' /etc/passwd                             //求乘积
awk '/MemFree/{print $2/1024}' /proc/meminfo                  //除法
awk '/MemFree/{print int($2/1024)}' /proc/meminfo           //取整
 
输出分隔符OFS
awk '$6 ~ /FIN/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt
awk '$6 ~ /WAIT/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt        
//输出字段6匹配WAIT的行，其中输出每行行号，字段4，5,6，并使用制表符分割字段
 
输出处理结果到文件
①在命令代码块中直接输出    route -n|awk 'NR!=1{print > "./fs"}'   
②使用重定向进行输出           route -n|awk 'NR!=1{print}'  > ./fs
 
格式化输出
netstat -anp|awk '{printf "%-8s %-8s %-10s\n",$1,$2,$3}' 
printf表示格式输出
%格式化输出分隔符
-8长度为8个字符
s表示字符串类型
打印每行前三个字段，指定第一个字段输出字符串类型(长度为8)，第二个字段输出字符串类型(长度为8),
第三个字段输出字符串类型(长度为10)
netstat -anp|awk '$6=="LISTEN" || NR==1 {printf "%-10s %-10s %-10s \n",$1,$2,$3}'
netstat -anp|awk '$6=="LISTEN" || NR==1 {printf "%-3s %-10s %-10s %-10s \n",NR,$1,$2,$3}'
 
IF语句
awk -F: '{if($3>100) print "large"; else print "small"}' /etc/passwd
small
small
small
large
small
small
awk -F: 'BEGIN{A=0;B=0} {if($3>100) {A++; print "large"} else {B++; print "small"}} END{print A,"\t",B}' /etc/passwd 
                                                                                                                  //ID大于100,A加1，否则B加1
awk -F: '{if($3<100) next; else print}' /etc/passwd                         //小于100跳过，否则显示
awk -F: 'BEGIN{i=1} {if(i<NF) print NR,NF,i++ }' /etc/passwd   
awk -F: 'BEGIN{i=1} {if(i<NF) {print NR,NF} i++ }' /etc/passwd
另一种形式
awk -F: '{print ($3>100 ? "yes":"no")}'  /etc/passwd 
awk -F: '{print ($3>100 ? $3":\tyes":$3":\tno")}'  /etc/passwd
 
while语句
awk -F: 'BEGIN{i=1} {while(i<NF) print NF,$i,i++}' /etc/passwd 
7 root 1
7 x 2
7 0 3
7 0 4
7 root 5
7 /root 6
 
数组
netstat -anp|awk 'NR!=1{a[$6]++} END{for (i in a) print i,"\t",a[i]}'
netstat -anp|awk 'NR!=1{a[$6]++} END{for (i in a) printf "%-20s %-10s %-5s \n", i,"\t",a[i]}'
9523                               1     
9929                               1     
LISTEN                            6     
7903                               1     
3038/cupsd                   1     
7913                               1     
10837                             1     
9833                               1     
 
应用1
awk -F: '{print NF}' helloworld.sh                                                       //输出文件每行有多少字段
awk -F: '{print $1,$2,$3,$4,$5}' helloworld.sh                                 //输出前5个字段
awk -F: '{print $1,$2,$3,$4,$5}' OFS='\t' helloworld.sh                 //输出前5个字段并使用制表符分隔输出
awk -F: '{print NR,$1,$2,$3,$4,$5}' OFS='\t' helloworld.sh           //制表符分隔输出前5个字段，并打印行号
 
应用2
awk -F'[:#]' '{print NF}'  helloworld.sh                                                  //指定多个分隔符: #，输出每行多少字段
awk -F'[:#]' '{print $1,$2,$3,$4,$5,$6,$7}' OFS='\t' helloworld.sh   //制表符分隔输出多字段
 
应用3
awk -F'[:#/]' '{print NF}' helloworld.sh                                               //指定三个分隔符，并输出每行字段数
awk -F'[:#/]' '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' helloworld.sh     //制表符分隔输出多字段
 
应用4
计算/home目录下，普通文件的大小，使用KB作为单位
ls -l|awk 'BEGIN{sum=0} !/^d/{sum+=$5} END{print "total size is:",sum/1024,"KB"}'
ls -l|awk 'BEGIN{sum=0} !/^d/{sum+=$5} END{print "total size is:",int(sum/1024),"KB"}'         //int是取整的意思
 
应用5
统计netstat -anp 状态为LISTEN和CONNECT的连接数量分别是多少
netstat -anp|awk '$6~/LISTEN|CONNECTED/{sum[$6]++} END{for (i in sum) printf "%-10s %-6s %-3s \n", i," ",sum[i]}'
 
应用6
统计/home目录下不同用户的普通文件的总数是多少？
ls -l|awk 'NR!=1 && !/^d/{sum[$3]++} END{for (i in sum) printf "%-6s %-5s %-3s \n",i," ",sum[i]}'   
mysql        199 
root           374 
统计/home目录下不同用户的普通文件的大小总size是多少？
ls -l|awk 'NR!=1 && !/^d/{sum[$3]+=$5} END{for (i in sum) printf "%-6s %-5s %-3s %-2s \n",i," ",sum[i]/1024/1024,"MB"}'
 
应用7
输出成绩表
awk 'BEGIN{math=0;eng=0;com=0;printf "Lineno.   Name    No.    Math   English   Computer    Total\n";printf "------------------------------------------------------------\n"}{math+=$3; eng+=$4; com+=$5;printf "%-8s %-7s %-7s %-7s %-9s %-10s %-7s \n",NR,$1,$2,$3,$4,$5,$3+$4+$5} END{printf "------------------------------------------------------------\n";printf "%-24s %-7s %-9s %-20s \n","Total:",math,eng,com;printf "%-24s %-7s %-9s %-20s \n","Avg:",math/NR,eng/NR,com/NR}' test0

[root@localhost home]# cat test0 
Marry   2143 78 84 77
Jack    2321 66 78 45
Tom     2122 48 77 71
Mike    2537 87 97 95
Bob     2415 40 57 62
```

练习：合并文件相邻2行

```
cat test.txt 
aaaa
bbbb
ccccc
ddd
方法一：
sed -n '{N;s/\n/\t/p}' test.txt
方法二：
awk '{tmp=$0;getline;print tmp"\t"$0}' test.txt
```

getline命令介绍

getline命令是我个人认为awk最强大的一个命令。因为它彻底改变了awk的运行逻辑。awk本质上就是一个for循环，它每次对输入文件的一行进行处理，然后转而执行下一行，直到整个文件的每一行都被执行完毕。整个过程是自动的，你无需做什么。但是，getline命令却可以让你去控制循环。当然，getline命令执行后，awk会设置NF，NR，FNR和$0等这些内部变量。

我们先看一个简单的例子，打印出从1到10之间的偶数：


fengxi@ubuntu:~/bash/awk$ seq 10 | awk '{getline; print $0}'
2
4
6
8
10
那么getline究竟是实现什么功能呢？正如getline的翻译，得到行，但是注意，得到的并不是当前行，而是当前行的下一行。以上面的例子来分析，awk首先读取到了第一行，就是1，然后getline，就得到了1下面的第二行，就是2，因为getline之后，awk会改变对应的NF，NR，FNR和$0等内部变量，所以此时的$0的值就不再是1，而是2了，然后将它打印出来。以此类推，就可以得到上面的结果。同样，我们可以利用getline只打印出奇数行。
fengxi@ubuntu:~/bash/awk$ seq 10 | awk '{print $0; getline}'
1
3
5
7
9
与打印偶数行的唯一区别就是print $0和getline的顺序不一样。因为getline在print $0之后，此时的$0仍然是第一行。然后getline，$0变成了下一行2。依次类推，就打印出了奇数行。
下一个我们换一个难一些的，就是奇偶行对调打印，原来在奇数行的内容将其打印在偶数行，原来在偶数行的内容将其打印在奇数行。


fengxi@ubuntu:~/bash/awk$ seq 10 | awk '{getline tmp; print tmp; print $0}'
2
1
4
3
6
5
8
7
10
9
上面例子将getline得到的下一行的内容放在了tmp这个变量里，因此NF，NR，FNR和$0等内部变量并不会被改变。
另外getline也可以从另外一个文件中读取内容。下面例子实现将两个文件的每一行都打印在一行上。


fengxi@ubuntu:~/bash/awk$ awk '{printf "%s ", $0; getline < "b.txt"; print $0}' a.txt 
1 6
2 7
3 8
4 9
5 10
a.txt文件的内容为上面打印出来的第一列，b.txt文件的内容为上面打印出来的第二列。
此外，getline也可以用来执行一个UNIX命令，并得到它的输出。下面例子通过getline得到系统的当前时间。

fengxi@ubuntu:~/bash/awk$ awk 'BEGIN {"date" | getline; close("date"); print $0}'
Tue May 10 07:50:51 PDT 2016

### sed命令

一 ，简介

```
sed 是一种在线的、非交互式的编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用 sed 命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。Sed 主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。
```

二、命令格式
sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)
注：
sed 和 grep 不一样，不管是否找到指定的模式，它的退出状态都是 0
只有当命令存在语法错误时，sed 的退出状态才是非 0

三、支持正则表达式
与 grep 一样，sed 在文件中查找模式时也可以使用正则表达式(RE)和各种元字符。正则表达
式是
括在斜杠间的模式，用于查找和替换，以下是 sed 支持的元字符。
使用基本元字符集 ^, $, ., *, [], [^], \< \>,\(\),\{\}
使用扩展元字符集 ?, +, { }, |, ( )
使用扩展元字符的方式：
\\+
sed -r

四、sed 基本用法

```
head /etc/passwd > passwd
# 屏幕输出
sed '' /etc/passwd # 无操作
sed 'd' /etc/passwd #删除所有，未对文件操作，只输出屏幕 i 参数实际操作文件
sed '4，7d' /etc/passwd #删除4~7行
# -r 扩展元字符 或 \+ 转义
sed -r 'd' /etc/passwd  #删除
sed -r 'p' /etc/passwd #打印，相同输出2行
sed -r -n 'p' /etc/passwd #不显示默认的那1行
sed -r -n '/root/p' /etc/passwd #输出带 root的行
sed -r 's/root/alice/' /etc/passwd #把root换成alice，只换每行找到的第一个
sed -r 's/root/alice/g' /etc/passwd  #把root全部换成alice，包含默认行
sed -r 's/Root/alice/gi' /etc/passwd #把root全部换成alice，忽略大小写
sed -r '/root/d' /etc/passwd #找到带root的行删除 写法1
sed -r '\#root#d' /etc/passwd #找到带root的行删除 写法2
sed -r '\crootcd' /etc/passwd
#使用 -ri参数 修改文件
```

```
[root@MiWiFi-R3-srv ~]# cat a.txt 
/etc/abc/456
etc
[root@MiWiFi-R3-srv ~]#  sed -r '\#/etc/abc/456#d' a.txt
etc
[root@MiWiFi-R3-srv ~]#  sed -r 's#/etc/abc/456#/dev/sda1#' a.txt 
/dev/sda1
etc
[root@MiWiFi-R3-srv ~]#  sed -r '/\/etc\/abc\/456/d' a.txt
etc
```

五、sed 扩展
＝＝地址（定址）
地址用于决定对哪些行进行编辑。地址形式可以是数字、正则表达式或二者的结合。如果没
有指定
地址，sed 将处理输入文件中的所有行。

```
sed -r 'd' passwd
sed -r '3d' passwd
sed -r '1,3d' passwd
sed -r '/root/d' passwd
sed -r '/root/,5d' passwd #从root 开始删除5行，多个root，分别从对应的行删除
sed -r 's/root/alice/g' passwd
sed -r '/^bin/,5d' passwd #找以bin开头的行，删到5行 cat -n passwd
sed -r '/^root/,+5d' passwd #找以bin开头的行，删到5行，再删5行， cat -n passwd      
sed -r '2,5d' passwd #找以bin开头的行，删到5行 cat -n passwd
sed -r '/root/d' passwd #删除带root行
sed -r '/root/!d' passwd #除了root行都删除
sed -r '1~2d' passwd //删除所有奇数行 odd-numbered
sed -r '0~2d' passwd //删除所有偶数行 even-numbere
```

＝＝sed 命令

```
sed 命令告诉 sed 对指定行进行何种操作，包括打印、删除、修改等。
命令 功能
a 在当前行后添加一行或多行
c 用新文本修改（替换）当前行中的文本
d 删除行
i 在当前行之前插入文本
l 列出非打印字符
p 打印行
n 读入下一输入行，并从下一条命令而不是第一条命令开始对其的处理 ,上面的n是参数，有区别
q 结束或退出 sed
! 对所选行以外的所有行应用命令
s  用一个字符串替换另一个
s 替换标志
g 在行内进行全局替换
i 忽略大小写
r 从文件中读
w 将行写入文件
y 将字符转换为另一字符（不支持正则表达式）
h 把模式空间里的内容复制到暂存缓冲区(覆盖)
H 把模式空间里的内容追加到暂存缓冲区
g 取出暂存缓冲区的内容，将其复制到模式空间，覆盖该处原有内容
G 取出暂存缓冲区的内容，将其复制到模式空间，追加在原有内容后面
x 交换暂存缓冲区与模式空间的内容
==选项
选项 功能
-e 允许多项编辑
-f 指定 sed 脚本文件名
-n 取消默认的输出
-i inplace，就地编辑
-r 支持扩展元字符
```

六、sed 命令示例
打印命令：p

```
sed -r '/north/p' datafile
sed -r -n '/north/p' datafile
```

删除命令：d

```
sed -r '3d' datafile
sed -r '3{d;}' datafile
sed -r '3{d}' datafile
sed -r '3,$d' datafile
sed -r '$d' datafile
sed -r '/north/d' datafile
sed -r '/sout/d' datafile

替换命令：s
sed -r 's/west/north/g' datafile
sed -r 's/^west/north/' datafile
sed -r 's/[0-9][0-9]$/&.5/' datafile //&代表在查找串中匹配到的内容
sed -r 's/Hemenway/Jones/g' datafile
sed -r 's/(Mar)got/\1ianne/g' datafile
sed -r 's#3#88#g' datafile
```

读文件命令：r

```
 sed -r '/Suan/r /etc/newfile' datafile
sed -r '2r /etc/hosts' a.txt
sed -r '/2/r /etc/hosts' a.txt
```

写文件命令：w

```
sed -r '/north/w newfile' datafile
sed -r '3,$w /new1.txt' datafile
```

追加命令：a

```
# sed -r '2a\1111111111111' /etc/hosts

# sed -r '2a\1111111111111\
>222222222222\
333333333333' /etc/hosts

```

插入命令：i

```
sed -r '2i\1111111111111' /etc/hosts
sed -r '2i111111111\

> 222222222222\
> 333333333333' /etc/hosts
```

修改命令：c

```
sed -r '2c\1111111111111' /etc/hosts
sed -r '2c\111111111111\
> 22222222222\
> 33333333333' /etc/hosts
```

获取下一行命令：n

```
sed -r '/eastern/{ n; d }' datafile
sed -r '/eastern/{ n; s/AM/Archile/ }' datafile
```

暂存和取用命令：h H g G

```
sed -r '1h;$G' /etc/hosts
sed -r '1{h;d};$G' /etc/hosts
sed -r '1h; 2,$g' /etc/hosts
sed -r '1h; 2,3H; $G' /etc/hosts
```

暂存空间和模式空间互换命令：x

```
sed -r '4h; 5x; 6G' /etc/hosts
```

反向选择: !

```
sed -r '3d' /etc/hosts
sed -r '3!d' /etc/hosts
```

多重编辑选项：e

```
sed -r -e '1,3d' -e 's/Hemenway/Jones/' datafile
sed -r '1,3d; s/Hemenway/Jones/' datafile
sed -r '2s/WE/UPLOOKING/g; 2s/Gray/YYY/g' datafile
sed -r '2{s/WE/UPLOOKING/g; s/Gray/YYY/g}' datafile
```

七、sed 常见操作
删除配置文件中#号注释行

```
sed -ri '/^#/d' file.conf
sed -ri '/^[ \t]*#/d' file.conf
```

删除配置文件中//号注释行

```
sed -ri '\Y^[ \t]*//Yd' file.conf
```

删除无内容空行

```
sed -ri '/^[ \t]*$/d' file.conf
```

删除注释行及空行：

```
sed -ri '/^[ \t]*#/d; /^[ \t]*$/d' /etc/vsftpd/vsftpd.conf
sed -ri '/^[ \t]*#|^[ \t]*$/d' /etc/vsftpd/vsftpd.conf
sed -ri '/^[ \t]*($|#)/d' /etc/vsftpd/vsftpd.conf
```

修改文件：

```
sed -ri '$a\chroot_local_user=YES' /etc/vsftpd/vsftpd.conf
sed -ri '/^SELINUX=/cSELINUX=disabled' /etc/selinux/config
sed -ri '/UseDNS/cUseDNS no' /etc/ssh/sshd_config
sed -ri '/GSSAPIAuthentication/cGSSAPIAuthentication no' /etc/ssh/sshd_config
```

给文件行添加注释：

```
sed -r '2,6s/^/#/' a.txt
sed -r '2,6s/(.*)/#\1/' a.txt
sed -r '2,6s/.*/#&/' a.txt &匹配前面查找的内容
sed -r '3,$ s/^#*/#/' a.txt 将行首零个或多个#换成一个#
sed -r '30,50s/^[ \t]*#*/#/' /etc/nginx.conf
sed -r '2,8s/^[ \t#]*/#/' /etc/nginx.conf
```



sed 中使用外部变量

```
var1=11111
sed -ri "3a$var1" /etc/hosts
sed -ri "$a$var1" /etc/hosts
sed -ri '$a\'"$var1" /etc/hosts
sed -ri 3a$var1 /etc/hosts
sed -ri "\$a$var1" /etc/hosts
```

练习：
``` 
[root@tianyun ~]# vim 12345.txt
1
2
3
4
5
[root@tianyun ~]# sed -r '1!G; $!h; $!d' 12345.txt
5
4
3
2
1
```
