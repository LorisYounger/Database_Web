<%
if Application("Key")="" then Application("Key")=int(Day(Now) + Month(Now)+ Year(Now))'访问秘钥(可以设置成动态的或者静态的)
if int(Request.querystring("Key"))<> Application("Key") then 
	Response.Write("Error KEY")
	Response.End
End if
dim Nid,info

Nid=Request.querystring("Nid")
info=Request.querystring("Info")

if Nid="" then Response.Write "No Nid"
if info="" then 
	Response.Write(Application(Nid))
else
	if info="@del" then
		Application(Nid)=""
	elseif left(info,4)="@add" then 
		Application(Nid)=Application(Nid)&replace(info,"@add","")
	else 
		Application(Nid)=info
	end if
	Response.Write("InputSuccess")
end if
Response.End
%>
