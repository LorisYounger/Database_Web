# Database_Web
简易的数据交换与储存 网页端

简易的数据交换与储存 网页端
方便的与不同软件服务器等进行数据传输
使用HTTP(S)传输，无需为端口对端口等数据传输而烦恼

如何使用：

主要功能 index.asp

提供一个数据库访问，四个主要数据类型：

ID 随系统自增，不可更改
Block 区块 主用来定位的名称
Nid 名称 辅用来定位的名称
Info 储存的信息

方法 操作数据

Key 访问秘钥(可以设置成动态的或者静态的) 用于验证权限

Action:
ReadAll 读取全部内容， 退回样式 id#1:|Block#区块:|Nid#区块指定值:|信息  +(回车)+下一个信息
ReadAllbyBlock 读取某一个区块的内容 需提供区块名 Block=区块名
Read 读取某一个数据 需提供Block，Nid 退回Info
Modify 修改某一个数据内容 需提供Block，Nid，info 退回是否修改成功
Input 添加一条数据 需提供Block，Nid，info 退回是否添加成功
Append 在其中一条数据后面增加内容 需提供Block，Nid，info 退回是否插入成功
Delete 删除指定数据 需提供Block，Nid 退回是否删除成功
MaxID 退回最大ID 注意当数据库为空时不退回值

使用案例  localhost/index.asp?key=000&Action=Input&Block=program1&Nid=admin&Info=admin|0|100
返回 Input Success 即代表成功在表中添加了 区块program1名称admin储存admin|0|100

辅助功能 temporaty.asp 缓存

注意 缓存的内容会在服务器超时时丢失，如需永久保存数据请使用 index.asp

Key 访问秘钥(可以设置成动态的或者静态的) 用于验证权限
Nid 名称 用来定位的名称
Info 储存的信息

其中 Info为空为读取
Info 中带有'@add'标记为添加内容(@add标记会被删除)
Info 中带有'@del'标记为删除内容