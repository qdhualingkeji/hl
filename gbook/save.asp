<!--#include file="../inc/AspCms_MainClass.asp" -->
<%
if action="add" then addFaq

Dim FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus
Sub addFaq
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "验证码不正确","-1"
	'if session("faq") then alertMsgAndGo "请不要重复提交","-1"
	FaqTitle=filterPara(getForm("FaqTitle","post"))
	Contact=filterPara(getForm("Contact","post"))
	ContactWay=filterPara(getForm("ContactWay","post"))
	Content=encode(filterPara(getForm("Content","post")))
	AddTime=now()
	FaqStatus=false
	AuditStatus=false
	
	if isnul(FaqTitle) then alertMsgAndGo "问题不能为空","-1"
	if isnul(Contact) then alertMsgAndGo "内容不能为空","-1"
	if isnul(ContactWay) then alertMsgAndGo "联系人不能为空","-1"
	if isnul(Content) then alertMsgAndGo "联系方式不能为空","-1"
	
	
	Conn.Exec"insert into Aspcms_Faq(FaqTitle,Contact,ContactWay,Content,AddTime,FaqStatus,AuditStatus) values('"&FaqTitle&"','"&Contact&"','"&ContactWay&"','"&Content&"','"&AddTime&"',"&FaqStatus&","&AuditStatus&")","exe"
	session("faq")=true
	
	if SwitchCommentsStatus=0 then
		alertMsgAndGo "留言成功！",getRefer	
	else	
		alertMsgAndGo "留言成功，请等待审核中！",getRefer	
	end if

	
End Sub

%>