<!--#include file="../inc/AspCms_MainClass.asp" -->
<%
echoContent()
Sub echoContent()
	dim page
	page=replaceStr(request.QueryString,FileExt,"")
	if isNul(page) then page=1
	if isNum(page) then page=clng(page) else echoMsgAndGo "ҳ�治����",3 end if
	dim templateobj,channelTemplatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/gbook.html"

	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		.parseList 0,page,"gbooklist","","gbook"
		.parseCommon() 
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub
%>
