<!--#include file="../inc/AspCms_MainClass.asp"-->
<%
dim SortID,Page,SortAndID
SortAndID=split(replaceStr(request.QueryString,FileExt,""),"_")
if isNul(replaceStr(request.QueryString,FileExt,"")) then  echoMsgAndGo "页面不存在",3 
SortID = SortAndID(0)
if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在",3 end if

'if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "页面不存在",3 end if
if ubound(SortAndID)=0 then page=1 else page=SortAndID(1) end if 

echoContent(SortID)

Sub echoContent(Byval SortID)
	dim templateobj,templatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim rsObj,rsObjSmalltype,rsObjBigtype,channelTemplateName,tempStr,tempArr,pageStr,content
	dim templateFile
	templateFile=getTemplateFile(SortID,"",0)
	if not CheckTemplateFile(templateFile) then echo templateFile&"模板文件不存在！"
	templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&templateFile
	
	templateObj.load(templatePath)
	templateObj.parseHtml()
set rsObjSmalltype = conn.Exec("select SortName,parentID,topsortid,PageKey,PageDesc from Aspcms_NewsSort where SortID="&SortID&"","r1")
if rsObjSmalltype.eof then echoMsgAndGo "参数错误！",3 
templateObj.content = replace(templateObj.content,"{aspcms:sortname}",rsObjSmalltype(0))
templateObj.content = replace(templateObj.content,"{aspcms:parentsortid}",rsObjSmalltype(1))		
templateObj.content= replace(templateObj.content,"{aspcms:sortid}",SortID)	
templateObj.content= replace(templateObj.content,"{aspcms:topsortid}",rsObjSmalltype(2))
if isnul(rsObjSmalltype(3)) then 
	templateObj.content= replace(templateObj.content,"{aspcms:sortkeyword}",siteKeyWords)	
else
	templateObj.content= replace(templateObj.content,"{aspcms:sortkeyword}",rsObjSmalltype(3))	
end if
if isnul(rsObjSmalltype(4)) then
	templateObj.content= replace(templateObj.content,"{aspcms:sortdesc}",decodeHtml(siteDesc))
else
	templateObj.content= replace(templateObj.content,"{aspcms:sortdesc}",rsObjSmalltype(4))
end if

set rsObjSmalltype=nothing
	templateObj.parsePosition(SortID) 
	templateObj.parseCommon	 
	
	tempStr = templateObj.content

		
	set rsObj = conn.Exec("select Title,TitleColor,NewsSource,[Content],Author,AddTime,NewsTag from Aspcms_News where SortID="&SortID&"","r1")
	if rsObj.eof then 
		echoMsgAndGo "还没有添加内容！",3
	else		
		content=decodeHtml(rsObj(3))
	    if isExistStr(content,"{aspcms:page}") then
		    tempArr = split(content,"{aspcms:page}")
			if isNul(Page) then Page=1
			if isNum(Page) then
				Page=clng(Page)
				if Page<1 then Page=1 : end if
				if Page>ubound(tempArr)+1 then Page=ubound(tempArr)+1 : end if
				if Page>2 then
				    pageStr=pageStr+"<div class='pages'><a href='"&runstr&SortID&"_"&Page-1&FileExt&"'>上一页</a>"
				else
				    pageStr=pageStr+"<div class='pages'><a href='"&runstr&SortID&FileExt&"'>上一页</a>"
				end if
				pageStr=pageStr+makePageNumber(Page,10,ubound(tempArr)+1,"about",SortID)
				if Page=ubound(tempArr)+1 then
				    pageStr=pageStr+"<a href='"&runstr&SortID&"_"&ubound(tempArr)+1&FileExt&"'>下一页</a></div>"
				else
				    pageStr=pageStr+"<a href='"&runstr&SortID&"_"&Page+1&FileExt&"'>下一页</a></div>"
				end if
				tempStr = replace(tempStr,"[about:info]",tempArr(Page-1)+pageStr)
			end if
		else
		    tempStr = replace(tempStr,"[about:info]",content)
		end if
		    tempStr = replace(tempStr,"[about:desc]",left(dropHtml(content),100))
		rsObj.close
		set rsObj = nothing
	end if	
	echo tempStr	
	
	set templateobj =nothing : terminateAllObjects
End Sub

%>
