<!--#include file="inc/AspCms_MainClass.asp" -->
<%
echoContent()
Sub echoContent()
	dim page,SortAndID
	page =filterPara(getForm("page","get"))
	if isNul(keys) then alertMsgAndGo "请输入关键词","-1"
	if isNul(page) then page=1
	if isNum(page) then page=clng(page) else echoMsgAndGo "页面不存在",3 end if
	
	dim templateobj,channelTemplatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr	
	if not CheckTemplateFile("search.html") then echo "search.html"&"模板文件不存在！"
	templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/search.html"

	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		.parseCommon() 		
		.parseList 0,page,"searchlist",keys,"product"		
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub
%>
