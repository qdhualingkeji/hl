<!--#include file="../inc/AspCms_MainClass.asp" -->
<%
if action = "login" then
	dim UserName,Password,sql,code,rs
	
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "��֤�벻��ȷ","-1"
	UserName = filterPara(getForm("username","post"))
	Password = md5(getForm("userPass","post"),16)
	
	sql = "select count(*) from Aspcms_Users where UserName = '"& UserName &"' and PassWord='"&Password&"'"
	Dim rsObj : Set rsObj=Conn.Exec(sql,"r1")
	if rsObj(0)=1 then
		Set rsObj=Conn.Exec("select UserId,userName,GradeMark from Aspcms_Users,Aspcms_UserGrades where Aspcms_Users.GradeID=Aspcms_UserGrades.GradeID and UserName='"&UserName&"' and UserStatus","r1")	
		if not rsObj.Eof Then
		'die rsObj("userName")	
			wCookie"loginName",rsObj("userName")	
			wCookie"userID",rsObj("UserId")			
			wCookie"loginstatus","1"
			session("GradeMark")=rsObj("GradeMark")
			
			Conn.Exec"update Aspcms_Users set LastLoginTime='"&now()&"',LastLoginIP='"&getIp()&"',LoginCount=LoginCount+1 where UserId="&rsObj("UserId"),"exe"			
			
			response.Redirect("/"&sitePath)
			response.End()
		else
			alertMsgAndGo "�Բ��������˺��ѱ�����!","-1"
		end if
	else
		alertMsgAndGo "�û������������,ϵͳ�������ص�¼ҳ��!","-1"
	end if
	rsObj.Close() : set rsObj=Nothing	
elseif action = "logout" then
	wCookie"loginName",""	
	wCookie"loginstatus","0"
	wCookie"userID",""
	session("GradeMark")=""
	alertMsgAndGo "���Ѿ��ɹ��˳���¼!","/"&sitePath
elseif action = "relog" then
	alertMsgAndGo "�Բ���,���ĵ�¼״̬�Ѿ�ʧЧ,�����µ�¼!","/"&sitePath
else
	echoContent()
end if

Sub echoContent()
	dim page
	page=replaceStr(request.QueryString,FileExt,"")
	if isNul(page) then page=1
	if isNum(page) then page=clng(page) else echoMsgAndGo "ҳ�治����",3 end if
	dim templateobj,channelTemplatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/login.html"

	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		.parseCommon() 
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub
%>