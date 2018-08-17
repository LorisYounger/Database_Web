<%
if Application("Key")="" then Application("Key")=int(Day(Now) + Month(Now)+ Year(Now))'访问秘钥(可以设置成动态的或者静态的)

if int(Request.querystring("Key"))<> Application("Key") then '当秘钥不通过时，回报错误秘钥
	Response.Write("Error KEY")
	Response.End
End if

dim conn,connstr,rs,sql

'on error resume next
connstr="DBQ="+server.mappath("Mata.mdb")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
set conn=server.createobject("ADODB.CONNECTION")
conn.open(connstr)

Select Case Request.querystring("Action")
Case "ReadAll"
	ReadAll
Case "ReadAllbyBlock"
	ReadAllbyBlock
Case "Read"
	Read
Case "Input"
	Input
Case"Append"
	Append
Case"Delete"
	Delete
Case"DeleteID"
	DeleteID
Case"Modify"
	Modify
Case"MaxID"
	MaxID
Case else
	Response.Write("NoAction")
End Select


CloseConn

Sub CloseConn'回收资源
on error resume next
	if isObject(rs) then
		rs.close
		set rs=nothing
	end if
	if isObject(conn) then
		conn.close  
		set conn=nothing
	end if
	Response.End
End sub

Sub ReadAllbyBlock
	set rs=server.createobject("adodb.recordset")
	Dim Block
	Block=Request.querystring("Block")
	sql="select * from data where Block='" & Block &"' order by ID desc"
	rs.open sql,Conn,1,1
	do while not rs.eof
		response.Write("id#"& rs("ID") &":|Block#"& rs("Block") &":|Nid#"& rs("Nid") & ":|"& rs("Info") & vbcrlf)
		rs.movenext
	loop
End Sub

Sub ReadAll
	set rs=server.createobject("adodb.recordset")
	sql="select * from data order by ID desc"
	rs.open sql,Conn,1,1
	do while not rs.eof
		response.Write("id#"& rs("ID") &":|Block#"& rs("Block") &":|Nid#"& rs("Nid") & ":|"& rs("Info") & vbcrlf)
		rs.movenext
	loop
End Sub

Sub Read
	set rs=server.createobject("adodb.recordset")
	Dim Nid,Block
	Nid=Request.querystring("Nid")
	Block=Request.querystring("Block")
	sql="select * from data where Nid='"& Nid &"' and Block='" & Block & "'"
	rs.open sql,Conn,1,1
	if not(rs.eof and rs.bof) then	response.Write(rs("Info"))	
End Sub

Sub Append
	set rs=server.createobject("adodb.recordset")
	Nid=Request.querystring("Nid")
	Block=Request.querystring("Block")
	Info=Request.querystring("Info")
	sql="select * from data where Nid='"& Nid &"' and Block='" & Block & "'"
	rs.open sql,Conn,1,3
	rs("Info")=rs("Info")&Info
	rs.update
	response.Write("Append Success")
End Sub

Sub Modify
	set rs=server.createobject("adodb.recordset")
	Nid=Request.querystring("Nid")
	Block=Request.querystring("Block")
	Info=Request.querystring("Info")
	sql="select * from data where Nid='"& Nid &"' and Block='" & Block & "'"
	rs.open sql,Conn,1,3
	rs("Info")=Info
	rs.update
	response.Write("Modify Success")
End Sub

Sub Input
	Dim Nid,Block,Info
	Nid=Request.querystring("Nid")
	Block=Request.querystring("Block")
	Info=Request.querystring("Info")
	sql="insert into data(Block,Nid,Info) values('" & Block & "','" & Nid & "','" & Info & "')"
	conn.execute sql
	response.Write("Input Success")
End Sub

Sub Delete
	Dim Nid,Block
	Nid=Request.querystring("Nid")
	Block=Request.querystring("Block")
	sql="delete from data where Nid='"& Nid &"' and Block='" & Block & "'"
	conn.execute sql
	response.Write("Delete Success")
End Sub

Sub DeleteID
	Dim ID
	ID=Request.querystring("ID")
	sql="delete from data where id=" & ID
	conn.execute sql
	response.Write("DeleteID Success")
End Sub


Sub MaxID
	set rs=server.createobject("adodb.recordset")
	sql="select max(id) as maxid from data"
	rs.open sql,Conn,1,1
	response.Write(rs("maxid"))	
End Sub

%>
