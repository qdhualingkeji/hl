<%
CheckLogin()
Server.ScriptTimeOut=36000
select case action
	case "all" : checkRunMode : makeAll()
	case "index" : checkRunMode : makeIndex()
	case "about" : checkRunMode : makeAllAbout()
	case "alllist" : checkRunMode : makeList()
	case "allcontent" : checkRunMode : makeContent()		
	case "list" : checkRunMode : makeListBySort()
	case "content" : checkRunMode : makeContentBySortID()	
end select

Sub checkRunMode
	if runmode<>1 then echoMsgAndGo "当前模式不是静态模式，不能生成！<a href=""../_Setting/AspCms_SeoSetting.asp"">点击此处修改运行模式</a>",10
End Sub

Sub makeAll()
	'DelAllHtml
	'die "AA"
	makeIndex()
	makeAllAbout()
	makeList()
	makeContent()
	alertMsgAndGo "生成全站成功","AspCms_MakeHtml.asp"	
End Sub

Sub makeList()
	dim rs,sql
	sql = "select SortID,SortStyle,SortName from Aspcms_NewsSort where SortStyle<>2 and SortStyle<>5"
	set rs=conn.Exec(sql,"r1")	
	Do While not rs.Eof
		makelistBySortid rs("SortID"),dir(rs("SortStyle"))
		echo "生成"""&rs("SortName")&"""成功<br>"
		rs.movenext
	Loop
	rs.close : set rs =nothing		
	if action<>"all" then alertMsgAndGo "生成列表页成功","AspCms_MakeHtml.asp"	
End Sub

Sub makeListBySort()
	dim rs,sql,SortID
	SortID=getForm("lsortid","post")
	if SortID=0 then alertMsgAndGo "请选择栏目","AspCms_MakeHtml.asp"	
	sql = "select SortID,SortStyle,SortName from Aspcms_NewsSort where SortStyle<>2 and SortStyle<>5 and SortID="&SortID
	set rs=conn.Exec(sql,"r1")	
	Do While not rs.Eof
		makelistBySortid rs("SortID"),dir(rs("SortStyle"))
		echo "生成"""&rs("SortName")&"""成功<br>"
		rs.movenext
	Loop
	rs.close : set rs =nothing	
	alertMsgAndGo "生成指定列表页成功","AspCms_MakeHtml.asp"	
End Sub

Sub makeContentBySortID()
	dim rs,sql,SortID
	SortID=getForm("csortid","post")
	if SortID=0 then alertMsgAndGo "请选择栏目","AspCms_MakeHtml.asp"	
	sql="select NewsID,Title,ImagePath,Author,NewsTag,Aspcms_News.AddTime,Aspcms_News.SortID,SortStyle from Aspcms_News,Aspcms_NewsSort where NewsStatus and (GradeID<2 or isnull(GradeID)) and Aspcms_News.SortID=Aspcms_NewsSort.SortID  and Aspcms_News.SortID="&SortID
'	die sql
	set rs=conn.Exec(sql,"r1")	
	Do While not rs.Eof		
		'echo "生成"""&rs("NewsID")&"""成功<br>"
		makeContentById rs("NewsID"),rs("SortID"),dir(rs("SortStyle"))
		rs.movenext
	Loop
	rs.close : set rs =nothing	
	if action<>"all" then alertMsgAndGo "生成指定内容页成功","AspCms_MakeHtml.asp"	
End Sub

'生成列表页
function makelistBySortid(Byval SortID,Byval str)
	dim page	
	dim templateobj,TemplatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype,channelTemplateName,tempStr,channelStr,PageKey,PageDesc,SortFolder
	dim templateFile
	templateFile=getTemplateFile(SortID,str,2)
	if not CheckTemplateFile(templateFile) then echo templateFile&"模板文件不存在！<br>":exit function
	templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&templateFile
	
	'TemplatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&str&"list.html"
	'labelRulePagelist = "\["&pageListType&":pagenumber([\s\S]*?)\]"
	templateObj.load(TemplatePath)
	tempstr=templateObj.content
	Dim objRegExp, Match, Matches ,pages
	Set objRegExp = New Regexp 
	objRegExp.IgnoreCase = True 
	objRegExp.Global = True 	
	objRegExp.Pattern = "{aspcms:"&str&"list([\s\S]*?)}([\s\S]*?){/aspcms:"&str&"list}"
	'进行匹配 	
	
	Set Matches = objRegExp.Execute(tempstr) 	
	For Each Match in Matches 
		'die Match.SubMatches(0)
		pages=templateObj.parseArr(Match.SubMatches(0))("size")
	Next 
	'die pages
	Set objRegExp = Nothing 	
	
	dim rs ,ParentID,topsortid
	set rs =conn.exec("select * from Aspcms_News where NewsStatus and SortID in ("&GetSmallestChild("Aspcms_NewsSort",sortid)&")","r1")
	if not rs.recordcount=0 then 
		if isnul(pages) then pages=rs.recordcount
		rs.pagesize=pages
		dim pcount
		pcount=rs.pagecount
		if pcount=0 then pcount=1
		for page=1 to pcount
			if not isNul(sortid) then	   
				set rsObj = conn.Exec("select top 1 sortID,(select count(*) from AspCms_NewsSort where ParentID=t.SortID),ParentID,topsortid,PageKey,PageDesc,SortFolder from Aspcms_NewsSort as t where  SortID="&sortid&"","r1")	
				
				if not rsObj.eof then typeIds=rsObj(0) else echoMsgAndGo "栏目不存在！",3 
				topsortid=rsObj("topsortid")
				ParentID=rsObj("ParentID")
				PageKey=rsObj("PageKey")
				PageDesc=rsObj("PageDesc")			
				SortFolder=rsObj("SortFolder")
				rsObj.close:set rsObj = nothing
			end if
			with templateObj 
				.load(TemplatePath)
				.parseHtml()
				.parsePosition(SortID)		
				.content= replace(.content,"{aspcms:sortid}",SortID)
				.content= replace(.content,"{aspcms:parentsortid}",ParentID)	
				.content= replace(.content,"{aspcms:topsortid}",topsortid)	
				if isnul(PageKey) then 	
					.content= replace(.content,"{aspcms:sortkeyword}",siteKeyWords)	
				else	
					.content= replace(.content,"{aspcms:sortkeyword}",PageKey)		
				end if
				if isnul(PageDesc) then
					.content= replace(.content,"{aspcms:sortdesc}",decodeHtml(siteDesc))
				else
					.content= replace(.content,"{aspcms:sortdesc}",PageDesc)
				end if
				.parseList typeIds,page,str&"list","",str		
				.parseCommon() 
				if isnul(SortFolder) then 
					SortFolder=str&"list"
				end if
				createTextFile  .content,"/"&sitePath&SortFolder&"/"&SortID&"_"&page&FileExt,""
			end with	
		next	
	end if
	rs.close : set rs=nothing
	set templateobj =nothing	
end function

'生成首页
Sub makeIndex()
	dim templateobj,templatePath : set templateobj = mainClassobj.createObject("MainClass.template")	
	templatePath="/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/index.html"
	with templateObj 
		.content=loadFile(templatePath) 
		.parseHtml()
		.parseCommon	
	 	createTextFile  .content,"/"&sitePath&"index"&FileExt,""
	end with
	set templateobj =nothing	
	'echoMsgAndGo "生成首页成功！",3 	
	if action<>"all" then alertMsgAndGo "生成首页成功","AspCms_MakeHtml.asp"		
End Sub


'按条件生成内容页
Sub makeContent()
	dim rs,sql
	sql="select NewsID,Title,ImagePath,Author,NewsTag,Aspcms_News.AddTime,Aspcms_News.SortID,SortStyle from Aspcms_News,Aspcms_NewsSort where NewsStatus and (GradeID<2 or isnull(GradeID)) and Aspcms_News.SortID=Aspcms_NewsSort.SortID  order by Aspcms_News.addtime desc"
	set rs=conn.Exec(sql,"r1")	
	Do While not rs.Eof
		echo "生成"""&rs("NewsID")&"""成功<br>"
		makeContentById rs("NewsID"),rs("SortID"),dir(rs("SortStyle"))
		rs.movenext
	Loop
	rs.close : set rs =nothing
	if action<>"all" then alertMsgAndGo "生成内容页成功","AspCms_MakeHtml.asp"	
End Sub


'生成所有单页
Sub makeAllAbout()
	dim rs,sql
	sql = "select SortID,SortStyle from Aspcms_NewsSort where SortStyle=2"
	set rs=conn.Exec(sql,"r1")	
	Do While not rs.Eof
		makeAboutBySortid rs("SortID"),dir(rs("SortStyle"))
		rs.movenext
	Loop
	rs.close : set rs =nothing
	if action<>"all" then alertMsgAndGo "生成所有单页成功","AspCms_MakeHtml.asp"
End Sub

function makeAboutBySortid(Byval SortID,Byval str)
	dim templateobj,templatePath : set templateobj = mainClassobj.createObject("MainClass.template")
	dim rsObj,rsObjSmalltype,rsObjBigtype,channelTemplateName,tempStr,tempArr,pageStr,content,Page,SortFolder

	set rsObj = conn.Exec("select Title,TitleColor,NewsSource,[Content],Author,AddTime,NewsTag from Aspcms_News where SortID="&SortID&"","r1")
	if rsObj.eof then 
		echo "该内容为空!<br/>"
	else		
		content=decodeHtml(rsObj(3))
		dim parr ,j
		parr =ubound(split(content,"{aspcms:page}"))
		if parr=-1 then parr=0
		for j=0 to parr
		
		
		dim templateFile
		templateFile=getTemplateFile(SortID,"",0)
		if not CheckTemplateFile(templateFile) then echo templateFile&"模板文件不存在！<br>":exit function
		templatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&templateFile
		
		templateObj.load(templatePath)
		templateObj.parseHtml()	 
		
		set rsObjSmalltype = conn.Exec("select SortName,parentID,topsortid,PageKey,PageDesc,SortFolder from Aspcms_NewsSort where SortID="&SortID&"","r1")
		if rsObjSmalltype.eof then echoMsgAndGo "参数错误！",3 
		templateObj.content = replace(templateObj.content,"{aspcms:sortname}",rsObjSmalltype(0))
		templateObj.content = replace(templateObj.content,"{aspcms:parentsortid}",rsObjSmalltype(1))
		templateObj.content = replace(templateObj.content,"{aspcms:topsortid}",rsObjSmalltype(2))			
		templateObj.content= replace(templateObj.content,"{aspcms:sortid}",SortID)	
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
		SortFolder=rsObjSmalltype(5)
		'die tempstr	
		set rsObjSmalltype=nothing	
	
		templateObj.parsePosition(SortID) 
		templateObj.parseCommon	 
		tempStr = templateObj.content
				if isExistStr(content,"{aspcms:page}") then		
					tempArr = split(content,"{aspcms:page}")
					if isNul(Page) then Page=1
					if isNum(Page) then
						Page=clng(Page)
						pageStr=""
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
				if isnul(SortFolder) then 
					SortFolder=str
				end if
			
				if j=0 then 					
					echo "/"&sitePath&SortFolder&"/"&SortID&FileExt&"<br>"
					createTextFile  tempStr,"/"&sitePath&SortFolder&"/"&SortID&FileExt,""
				else
					echo "/"&sitePath&SortFolder&"/"&SortID&"_"&j+1&FileExt&"<br>"
					createTextFile  tempStr,"/"&sitePath&SortFolder&"/"&SortID&"_"&j+1&FileExt,""				
				end if	
				Page=Page+1
			next
		
		rsObj.close
		set rsObj = nothing
	end if	 
	set templateobj =nothing 
end function

function makeContentById(Byval ID,Byval SortID,Byval str)
	dim sql,sperStr,sperStrs,content,SortFolder
	if str="product" then 
		sperStrs =conn.Exec("select SpecField from Aspcms_ProductSpecSet Order by SpecOrder Asc,SpecID", "arr")
		dim spec
		if isarray(sperStrs) then
			for each spec in sperStrs
				sperStr = sperStr&","&spec
			next
		end if
	end if
	
	sql="select Title,TitleColor,NewsSource,[Content],Author,AddTime,NewsTag,Visits,ImagePath,downurl,PageDesc "&sperStr&" from Aspcms_News where NewsStatus and NewsID="&Id&""
	
	set rsObj = conn.Exec(sql,"r1")
	
'	set rsObj = conn.Exec("select Title,TitleColor,NewsSource,[Content],Author,AddTime,NewsTag,Visits,ImagePath,downurl from Aspcms_News where NewsStatus and NewsID="&Id&"","r1")
	if not rsObj.eof then 
		dim j
			
			content=decodeHtml(rsObj(3))
			
			
			tempArr = split(content,"{aspcms:page}")
			dim parr 
			parr =ubound(tempArr)
			if parr=-1 then parr=0
			for j=0 to parr
	
				dim templateobj,TemplatePath : set templateobj = mainClassobj.createObject("MainClass.template")
				dim rsObj,rsObjSmalltype,rsObjBigtype,channelTemplateName,tempStr,tempArr,pageStr,Page
				TemplatePath = "/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&str&".html"	
				with templateObj					 
					 .load(TemplatePath)
					 .parseHtml()
					 if SwitchComments=1 then
						.content= replace(.content,"{aspcms:comment}",loadFile("/"&sitePath&"plug/comment.html"))	'加载评论模板
					 else
						.content= replace(.content,"{aspcms:comment}","")
					 end if
					set rsObjSmalltype = conn.Exec("select SortName,ParentID,topsortid,SortFolder from Aspcms_NewsSort where SortID="&SortID&"","r1")
					.content = replace(.content,"{aspcms:sortname}",rsObjSmalltype(0))		
					.content = replace(.content,"{aspcms:parentsortid}",rsObjSmalltype(1))	
					.content = replace(.content,"{aspcms:topsortid}",rsObjSmalltype(2))		
					.content = replace(.content,"{aspcms:sortid}",SortID)	
					.content= replace(.content,"["&str&":id]",Id)
		 			.content= replace(.content,"[news:id]",Id)
					SortFolder=rsObjSmalltype(3)
					set rsObjSmalltype=nothing
					 .parsePosition(SortID) 
					 .parseCommon() 
					 .parsePrevAndNext id,SortID					 
					.content= replace(.content,"["&str&":tag]",replace(replace(repnull(rsObj(6))," ",","),"，",","))
					.parseLoop("aboutart")
				end with	
				
				tempStr = templateObj.content
				
				tempStr = replace(tempStr,"["&str&":title]",rsObj(0))
				dim newsSource 
				if isnul(rsObj(2)) then newsSource=siteTitle else newsSource=repnull(rsObj(2)) end if
				tempStr = replace(tempStr,"["&str&":source]",newsSource)			
			
				if str="product" then 				
					if isarray(sperStrs) then
						for each spec in sperStrs			
							tempStr = replace(tempStr,"["&str&":"&spec&"]",repnull(rsObj(spec)))
						next
					end if
				end if	
							
				dim imgPath
				if isnul(rsObj(8)) then imgPath="/"&sitePath&"images/nopic.gif" else imgPath=rsObj(8)
				tempStr = replace(tempStr,"["&str&":pic]",imgPath)	
				'if not isnul(rsObj(9))
				if isExistStr(tempStr,"["&str&":downurl]") then
					Dim downUrlStr,downUrls ,i	
					downUrls = split(repnull(rsObj(9)),",")
					for i=0 to ubound(downUrls)
						if  not isnul(trim(downUrls(i))) then 
							downUrlStr=downUrlStr&" <a href="""&downUrls(i)&"""  target=""_blank"">下载地址"&i+1&"</a> &nbsp;"
						end if
					next
					tempStr = replace(tempStr,"["&str&":downurl]",downUrlStr)
				end if	
				tempStr = replace(tempStr,"["&str&":date]",repnull(rsObj(5)))
				tempStr = replace(tempStr,"["&str&":visits]","<script src=""/"&sitePath&"inc/AspCms_Visits.asp?id="&id&"""></script>")			
				tempStr =tempStr&"<script src=""/"&sitePath&"inc/AspCms_VisitsAdd.asp?id="&id&"""></script>"
				'tempStr = replace(tempStr,"["&str&":desc]",left(dropHtml(content),100))
				if isnul(rsObj(10)) then 
					tempStr = replace(tempStr,"["&str&":desc]",left(dropHtml(content),100))
				else
					tempStr = replace(tempStr,"["&str&":desc]",rsObj(10))			
				end if
				
				'tempStr = replace(tempStr,"{aspcms:sort}",GetTopId(SortID))
				
		
				if isnul(SortFolder) then 
					SortFolder=str
				end if
				tempStr = replace(tempStr,"["&str&":link]","http://"&siteUrl&"/"&SortFolder&"/"&runstr&SortID&"_"&ID&FileExt)
				if isExistStr(content,"{aspcms:page}") then
					tempArr = split(content,"{aspcms:page}")
					if isNul(Page) then Page=1
					Page=j+1
					if isNum(Page) then
						Page=clng(Page)
						pageStr=""
						if Page<1 then Page=1 : end if
						if Page>ubound(tempArr)+1 then Page=ubound(tempArr)+1 : end if
						if Page=1 or page=2 then
							pageStr=pageStr+"<div class='pages'><a href="""&runstr&SortID&"_"&ID&FileExt&""">上一页</a>"
						else
							pageStr=pageStr+"<div class='pages'><a href="""&runstr&SortID&"_"&ID&"_"&Page-1&FileExt&""">上一页</a>"
						end if
						pageStr=pageStr+makePageNumber(Page,10,ubound(tempArr)+1,ID,SortID)
						if Page=ubound(tempArr)+1 then
							pageStr=pageStr+"<a href="""&runstr&SortID&"_"&ID&"_"&ubound(tempArr)+1&FileExt&""">下一页</a></div>"
						else
							pageStr=pageStr+"<a href="""&runstr&SortID&"_"&ID&"_"&Page+1&FileExt&""">下一页</a></div>"
						end if
						tempStr = replace(tempStr,"["&str&":info]",tempArr(Page-1)+pageStr)
					end if
					if j=0 then 
						echo "/"&sitePath&SortFolder&"/"&SortID&"_"&ID&FileExt&"<br>"
						createTextFile tempStr,"/"&sitePath&SortFolder&"/"&SortID&"_"&ID&FileExt,""	
					else					
						echo "/"&sitePath&SortFolder&"/"&SortID&"_"&ID&"_"&j+1&FileExt&"<br>"
						createTextFile tempStr,"/"&sitePath&SortFolder&"/"&SortID&"_"&ID&"_"&j+1&FileExt,""				
					end if			
				else
					tempStr = replace(tempStr,"["&str&":info]",repnull(content))
					echo "/"&sitePath&SortFolder&"/"&SortID&"_"&ID&FileExt&"<br>"
					createTextFile tempStr,"/"&sitePath&SortFolder&"/"&SortID&"_"&ID&FileExt,""
				end if			
			next
			rsObj.close	: set rsObj = nothing
	end if		
	set templateobj =nothing			
End function


Sub DelAllHtml
	dim styles,style
	styles=split("news,down,pic,product,about,",",")	
	if isExistFile("/"&sitePath&"index.html") then delFile "/"&sitePath&"index.html"	'删除首页	
	for each style in styles
		if style="news" or style="down" or style="pic" or style="product" then Delhtml(style&"list")	'删除列表页
		Delhtml(style)			'删除详细页				
	next	
	'删除指定的生成目录
	styles=""
	styles=conn.exec("select SortFolder from Aspcms_NewsSort where not isnull(SortFolder)","arr")
	for each style in styles
		'if not isnul(style) then echo "/"&sitePath&style&"<br>"
		'Delhtml(style)			'删除详细页			
		if not isnul(style) and isExistFolder("/"&sitePath&style) then Delhtml(style)	
	next
End Sub

'根据目录删除html文件
Sub Delhtml(str)
	dim fileListArray,fileAttr,i
	fileListArray= getFileList("/"&sitePath&str)
	if instr(fileListArray(0),",")>0 then		
		for  i = 0 to ubound(fileListArray)
			fileAttr=split(fileListArray(i),",")	
			if GetExtend(fileAttr(0))=replace(FileExt,".","") then delFile fileAttr(4)	
		next		
	end if
End Sub
%>
