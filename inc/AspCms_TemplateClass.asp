<%
Class MainClass_Template
	Public content,allPages,currentPage,currentType
	Private cacheName,labelRule,regExpObj,strDictionary
	'初始化类
	Public Sub Class_Initialize()
		set regExpObj= new RegExp
		regExpObj.ignoreCase=false
		regExpObj.Global=true
		set strDictionary=server.CreateObject(DICTIONARY_OBJ_NAME)
	End Sub
	
	Public Sub Class_Terminate()
		set regExpObj=nothing
		set strDictionary=nothing
	End Sub

	'加载文件
	Public Function load(Byval filePath)
		content=loadFile(filePath)
	End Function

	'解析头部和底部
	Public Function parseTopAndFoot()
		content=replaceStr(content,"{aspcms:top}",loadFile("/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/head.html"))
		content=replaceStr(content,"{aspcms:foot}","<script type=""text/javascript"" src=""/"&sitePath&"inc/AspCms_Statistics.asp""></script>"&loadFile("/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/foot.html"))	
	End Function
	
	Public Function parseAuxiliaryTemplate()
		Dim labelRuleRuxiliaryTemplate,matchesRuxiliary,matchRuxiliary,srcTemplate
		labelRuleRuxiliaryTemplate = "\{aspcms:template([\s\S]*?)\}"
		regExpObj.Pattern = labelRuleRuxiliaryTemplate
		set matchesRuxiliary = regExpObj.Execute(content)
		for each matchRuxiliary in matchesRuxiliary			
			srcTemplate = parseArr(matchRuxiliary.SubMatches(0))("src")			
			content=replaceStr(content,"{aspcms:template src="&srcTemplate&"}",loadFile("/"&sitePath&"templates/"&defaultTemplate&"/"&htmlFilePath&"/"&srcTemplate))
		next
		set matchesRuxiliary = nothing	
	End Function
	
	'解析全局标签
	Public Function parseGlobal()		
		content=replaceStr(content,"{aspcms:sitelogo}",siteLogoUrl)
		content=replaceStr(content,"{aspcms:companyname}",companyName)
		content=replaceStr(content,"{aspcms:additiontitle}",additionTitle)
		content=replaceStr(content,"{aspcms:companyaddress}",companyAddress)
		content=replaceStr(content,"{aspcms:companypostcode}",companyPostCode)
		content=replaceStr(content,"{aspcms:companycontact}",companyContact)
		content=replaceStr(content,"{aspcms:companyphone}",companyPhone)
		content=replaceStr(content,"{aspcms:companymobile}",companyMobile)
		content=replaceStr(content,"{aspcms:companyfax}",companyFax)
		content=replaceStr(content,"{aspcms:companyemail}",companyEmail)
		content=replaceStr(content,"{aspcms:companyicp}",companyICP)
		content=replaceStr(content,"{aspcms:statisticalcode}",statisticalCode)
		content=replaceStr(content,"{aspcms:username}",rCookie("loginName"))
		'content=replaceStr(content,"{aspcms:siteTitle}",siteTitle)
		content=replaceStr(content,"{aspcms:siteurl}",siteUrl)
		content=replaceStr(content,"{aspcms:sitepath}",sitePath)
		content=replaceStr(content,"{aspcms:defaulttemplate}",defaultTemplate)
		content=replaceStr(content,"{aspcms:sitetitle}",siteTitle)
		content=replaceStr(content,"{aspcms:copyright}",decodeHtml(copyRight))
		content=replaceStr(content,"{aspcms:sitedesc}",decodeHtml(siteDesc))
		content=replaceStr(content,"{aspcms:sitenotice}",decodeHtml(siteNotice))
		content=replaceStr(content,"{aspcms:sitekeywords}",siteKeyWords)
		content=replaceStr(content,"{aspcms:floatad}",getFloatAD)
		content=replaceStr(content,"{aspcms:slide}",getslide)
		content=replaceStr(content,"{aspcms:53kf}",getkf)
		content=replaceStr(content,"images/","/"&sitePath&"templates/"&defaultTemplate&"/images/")
		content=replaceStr(content,"{aspcms:onlineservice}",getonlineservice)			
	End Function

			
	'获取可用标签参数
	Public Function parseArr(Byval attr)
		dim attrStr,attrArray,attrDictionary,i,singleAttr,singleAttrKey,singleAttrValue
		attrStr = regExpReplace(attr,"[\s]+",chr(32))
		attrStr = trim(attrStr)
		attrArray = split(attrStr,chr(32))
		for i=0 to ubound(attrArray)
			singleAttr = split(attrArray(i),chr(61))
			singleAttrKey =  singleAttr(0) : singleAttrValue =  singleAttr(1)
			if not strDictionary.Exists(singleAttrKey) then strDictionary.add singleAttrKey,singleAttrValue else strDictionary(singleAttrKey) = singleAttrValue
		next
		set parseArr = strDictionary
	End Function

	Public Function regExpReplace(contentstr,patternstr,replacestr)
		regExpObj.Pattern=patternstr
		regExpReplace=regExpObj.replace(contentstr,replacestr)
	End Function
	
	'解析导航栏
	Public Function parseNavList(str)	
		if not isExistStr(content,"{aspcms:"&str&"navlist") then Exit Function
		dim match,matches,matchfield,matchesfield,num
		dim labelAttrLinklist,loopstrLinklist,loopstrLinklistNew,loopstrTotal
		dim vtype,vnum,whereStr,linkArray
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,labelRuleField
		dim m,namelen,deslen,m_des
		labelRule="{aspcms:"&str&"navlist([\s\S]*?)}([\s\S]*?){/aspcms:"&str&"navlist}"
		labelRuleField="\["&str&"navlist:([\s\S]+?)\]"
		regExpObj.Pattern=labelRule
		set matches=regExpObj.Execute(content)
		
		for each match in matches
			labelAttrLinklist=match.SubMatches(0)
			loopstrLinklist=match.SubMatches(1)
			vtype=parseArr(labelAttrLinklist)("type") 	
			if isnul(vtype) then vtype=0		
			linkArray=conn.Exec("select  SortName,SortStyle,SortURL,sortID ,(select count (*) from Aspcms_NewsSort as a where a.ParentID=b.sortID) as subcount,SortFolder,PageDesc,SortPic from Aspcms_NewsSort as b  where SortStatus and ParentID="&vtype&" order by SortOrder asc","arr")
			if not isarray(linkArray) then  vnum=-1  else vnum=ubound(linkArray,2)
			regExpObj.Pattern=labelRuleField
			set matchesfield=regExpObj.Execute(loopstrLinklist)
			loopstrTotal=""
			for i=0 to vnum
				loopstrLinklistNew=loopstrLinklist
				for each matchfield in matchesfield
					fieldNameAndAttr=regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr=trimOuter(fieldNameAndAttr)
					m=instr(fieldNameAndAttr,chr(32))
					if m > 0 then 
						fieldName=left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName=fieldNameAndAttr
						fieldAttr =	""
					end if
					select case fieldName
						case "name"
							namelen=parseArr(fieldAttr)("len") 
							if isNul(namelen) then 
								loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(0,i))
							else 
								namelen=clng(namelen)
								loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,left(linkArray(0,i),namelen)&"..")
							end if 
							'loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(0,i))
						case "link"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,getUrl(linkArray(1,i),linkArray(3,i),linkArray(2,i),linkArray(5,i)))
							
							'echo getUrl(linkArray(1,i),linkArray(3,i),linkArray(2,i),linkArray(5,i))&"<br>"
						case "sortid"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(3,i))
						case "subcount"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(4,i))
						case "desc"
							m_des=decodeHtml(linkArray(3,i)):deslen=parseArr(fieldAttr)("len")
							if isNul(deslen) then deslen=100
							if len(m_des) > clng(deslen) then  m_des=left(m_des,clng(deslen)-1)&".."
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,m_des)
						case "pagedesc"
							m_des=decodeHtml(linkArray(6,i)):deslen=parseArr(fieldAttr)("len")
							if isNul(deslen) then deslen=80
							if len(m_des) > clng(deslen) then  m_des=left(m_des,clng(deslen)-1)&".."
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,m_des)
						case "sortpic"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(7,i))		
						case "i"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,i+1)
						case "cursortid"
						If runMode = 0 and request.QueryString<>"" Then 
							dim m_SortAndID
							m_SortAndID=split(replaceStr(request.QueryString,FileExt,""),"_")
							if IsArray(m_SortAndID) then
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,m_SortAndID(0))
							End If 
						End If
						
					end select
				next
				loopstrTotal=loopstrTotal&loopstrLinklistNew
			next
			set matchesfield=nothing
			content=replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches=nothing
		if instr(content,"{aspcms:subnavlist")>0 then parseNavList("sub") else Exit Function
	End Function
	
	'解析RSS
	Public Function parseRssList(str)	
		if not isExistStr(content,"{aspcms:"&str&"rsslist") then Exit Function
		dim match,matches,matchfield,matchesfield
		dim labelAttrLinklist,loopstrLinklist,loopstrLinklistNew,loopstrTotal
		dim vtype,vnum,whereStr,linkArray
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,labelRuleField
		dim m,namelen,deslen,m_des
		labelRule="{aspcms:"&str&"rsslist([\s\S]*?)}([\s\S]*?){/aspcms:"&str&"rsslist}"
		labelRuleField="\["&str&"rsslist:([\s\S]+?)\]"
		regExpObj.Pattern=labelRule
		set matches=regExpObj.Execute(content)
		
		for each match in matches
			labelAttrLinklist=match.SubMatches(0)
			loopstrLinklist=match.SubMatches(1)
			vtype=parseArr(labelAttrLinklist)("type") 	
			if isnul(vtype) then vtype=0		
			linkArray=conn.Exec("select SortName,SortStyle,SortURL,sortID ,(select count (*) from Aspcms_NewsSort as a where a.ParentID=b.sortID) as subcount,SortFolder from Aspcms_NewsSort as b  where SortStatus and ParentID="&vtype&" order by SortOrder asc","arr")
			if not isarray(linkArray) then  vnum=-1  else vnum=ubound(linkArray,2)
			regExpObj.Pattern=labelRuleField
			set matchesfield=regExpObj.Execute(loopstrLinklist)
			loopstrTotal=""
			for i=0 to vnum
				loopstrLinklistNew=loopstrLinklist
				for each matchfield in matchesfield
					fieldNameAndAttr=regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr=trimOuter(fieldNameAndAttr)
					m=instr(fieldNameAndAttr,chr(32))
					if m > 0 then 
						fieldName=left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName=fieldNameAndAttr
						fieldAttr =	""
					end if
					select case fieldName
						case "name"
							'namelen=parseArr(fieldAttr)("len") : if isNul(namelen) then namelen=8 else namelen=clng(namelen)
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(0,i))
						case "link"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,"/"&sitePath&"rss/"&linkArray(3,i)&".xml")							
							'echo getUrl(linkArray(1,i),linkArray(3,i),linkArray(2,i),linkArray(5,i))&"<br>"
						case "sortid"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(3,i))
						case "subcount"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(4,i))
						case "desc"
							m_des=decodeHtml(linkArray(3,i)):deslen=parseArr(fieldAttr)("len")
							if isNul(deslen) then deslen=100
							if len(m_des) > clng(deslen) then  m_des=left(m_des,clng(deslen)-1)&".."
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,m_des)
						case "i"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,i+1)
					end select
				next
				loopstrTotal=loopstrTotal&loopstrLinklistNew
			next
			set matchesfield=nothing
			content=replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches=nothing
		if instr(content,"{aspcms:subrsslist")>0 then  parseRssList("sub") else Exit Function
	End Function
	
	'获取导航栏链接
	Function getUrl(sortStyle,sortID,sortUrl,SortFolder)
		if runMode=1 and not isnul(SortFolder) then 
			Select  case sortStyle
				case "0" 
					getUrl="/"&sitePath&SortFolder&"/"&runstr&sortID&"_1"&FileExt					
				case "1" 			
					getUrl="/"&sitePath&SortFolder&"/"&runstr&sortID&"_1"&FileExt			
				case "2" 
					getUrl="/"&sitePath&SortFolder&"/"&runstr&sortID&FileExt		
				case "3" 
					getUrl="/"&sitePath&SortFolder&"/"&runstr&sortID&"_1"&FileExt	
				case "4" 
					getUrl="/"&sitePath&SortFolder&"/"&runstr&sortID&"_1"&FileExt	
				case else
					if isurl(sortUrl) then
						getUrl=sortUrl
					else
						getUrl="/"&sitePath&sortUrl
					end if 
			End Select
		else
			Select  case sortStyle
				case "0" 
					getUrl="/"&sitePath&"newslist/"&runstr&sortID&"_1"&FileExt						
				case "1" 			
					getUrl="/"&sitePath&"piclist/"&runstr&sortID&"_1"&FileExt			
				case "2" 
					getUrl="/"&sitePath&"about/"&runstr&sortID&FileExt	
				case "3" 
					getUrl="/"&sitePath&"productlist/"&runstr&sortID&"_1"&FileExt	
				case "4" 
					getUrl="/"&sitePath&"downlist/"&runstr&sortID&"_1"&FileExt	
				case else
					if isurl(sortUrl) then
						getUrl=sortUrl
					else
						getUrl="/"&sitePath&sortUrl
					end if 
			End Select
		end if
	End Function
	
	'替换循环标签
	Public Function parseLoop(Byval str)	
		dim sortArr,sortStr,sortI,labelRuleField,matches,match,labelStr,loopStr,labelArr,lnum,ltype,lsort,lorder,ltime,whereType,whereSort,orderStr,whereTime,sql,DateArray,matchesfield,loopstrTotal,i,sperStrs,spec,sperStr,aboutkey,title
		labelRule = "{aspcms:"&str&"([\s\S]*?)}([\s\S]*?){/aspcms:"&str&"}"
		labelRuleField = "\["&str&":([\s\S]+?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
		    labelStr = match.SubMatches(0)
			loopStr = match.SubMatches(1)
			set labelArr = parseArr(labelStr)
			lnum = labelArr("num") : ltype = labelArr("type") : lsort = labelArr("sort") : lorder = labelArr("order") : ltime = labelArr("time") : aboutkey = labelArr("key")
			if isNul(ltype) then ltype="all"
			if ltype="all" then 			
				whereType=""
			end if
			
			if isNul(lnum) then lnum = 10  else lnum = cint(lnum)
			sortStr=""
			if isNul(lsort) then lsort="all"
			if lsort <> "all" then 
				if instr(lsort,",")>0 then 
					sortArr=split(lsort,",")
					for sortI=0 to ubound(sortArr)
						sortStr=sortStr&sortArr(sortI)&","
					next
					sortStr=GetSmallestChild("Aspcms_NewsSort",sortStr)
				else
					sortStr=lsort
				end if
				whereSort=" and SortID in ("&GetSmallestChild("Aspcms_NewsSort",sortStr)&")"
			else 
				whereSort=""
			end if
			if isNul(lorder) then lorder = "time"
			select case lorder           
				case "id" : orderStr =" order by IsTop,isrecommend,NewsID desc"
				case "visits" : orderStr =" order by Visits desc"
				case "time" : orderStr =" order by AddTime desc"
				case "order" : orderStr =" order by IsTop,isrecommend,NewsOrder "&orderAsc&",AddTime desc"				
				case "istop" : orderStr =" and IsTop order by IsTop,isrecommend,AddTime desc"
				case "isrecommend" : orderStr =" and isrecommend order by IsTop,isrecommend,AddTime desc" 
			end select

			select case ltime
				case "day" : whereTime = " and  DateDiff('d',AddTime,now())=0"
				case "week" : whereTime = " and  DateDiff('w',AddTime,now())=0"
				case "month" : whereTime = " and  DateDiff('m',AddTime,now())=0"
				case else : whereTime=""
			end select
			
			'echo whereTime&"<br>"
			
				if str="product" then 
					sperStrs =conn.Exec("select SpecField from Aspcms_ProductSpecSet Order by SpecOrder Asc,SpecID", "arr")				
					if isarray(sperStrs) then
						for each spec in sperStrs
							sperStr = sperStr&","&spec
						next
					end if
				end if
			
			set labelArr = nothing
			if str="news" or str="product" or str="down" or str="pic" then
				sql="select top "&lnum&" NewsID,Title,IsOutLink,Visits,ImagePath,AddTime,OutLink,Content,SortID,TitleColor,IsTop,isrecommend,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID,(SELECT SortName FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID) "&sperStr&"  from Aspcms_News where NewsStatus "&whereType&whereSort&whereTime&orderStr
				
			'echo sql&"<br>"					
			elseif str="about" then
				sql="select Content,NewsID,SortID,Title,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID) from Aspcms_News where SortID="&lsort&""	
			elseif str="type" then			
				sql="select SortName,SortURL,SortStyle,SortFolder from Aspcms_NewsSort where SortStatus and SortID="&lsort&""	
			elseif str="gbook" then	
				if SwitchFaqStatus=0 then 			
					sql="select FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus from Aspcms_Faq order by AddTime"
				else
					sql="select FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus from Aspcms_Faq where FaqStatus order by AddTime"
				end if
			elseif str="tag" then			
					sql="select top "&lnum&" NewsTag from Aspcms_News where  NOT isNULL(NewsTag) and NewsStatus "&whereType&whereSort&whereTime&orderStr	
			elseif str="aboutart" then				
				dim ltypestr: ltypestr=""
					if not isnul(ltype) and not ltype="all" then ltypestr=" and sortstyle="&ltype	
					dim aboutkeystr,aboutkeys,ak
					
					if Instr(aboutkey,",") > 0 then
						aboutkey = Split(aboutkey,",")
						aboutkeystr = aboutkeystr &"("
						For i = 0 to Ubound(aboutkey)
							aboutkeystr = aboutkeystr &" Title like '%"& aboutkey(i) &"%'"
							if i = Ubound(aboutkey) then
								aboutkeystr = aboutkeystr &") "
							else
								aboutkeystr = aboutkeystr &" Or "
							end if
						Next
					else
						aboutkeystr = aboutkeystr &" Title like '%"& aboutkey &"%' "
					end if					
					 	
					sql="select  top "&lnum&" NewsID,Title,IsOutLink,Visits,ImagePath,Aspcms_News.AddTime,OutLink,Content,Aspcms_News.SortID,TitleColor,IsTop,isrecommend,sortStyle,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID,SortName from Aspcms_News,Aspcms_NewsSort where Aspcms_News.SortID=Aspcms_NewsSort.SortID and NewsStatus and Aspcms_News.SortID in (select Aspcms_NewsSort.sortid from Aspcms_NewsSort where 1=1 "&ltypestr&whereSort&") and "&aboutkeystr						
			end if			
			
			conn.fetchCount=lnum
			DateArray = conn.Exec(sql,"arr")
			dim rsObj
			set rsObj = conn.Exec(sql,"r1")
			conn.fetchCount=0
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopStr)
			loopstrTotal = ""
			if isArray(DateArray) then lnum = ubound(DateArray,2) else lnum=-1
			dim nloopstr,matchfield,fieldNameArr,m,fieldName,fieldArr,infolen,namelen,timestyle
			
			for i = 0 to lnum
			    nloopstr=loopStr
			    for each matchfield in matchesfield
					fieldNameArr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameArr = trim(fieldNameArr)
					m = instr(fieldNameArr,chr(32))
					if  m > 0 then 
						fieldName = left(fieldNameArr,m - 1)
						fieldArr =	right(fieldNameArr,len(fieldNameArr) - m)
					else
						fieldName = fieldNameArr
						fieldArr =	""
					end if
					
					
					if str="news" or str="product" or str="down" or str="pic" or str="aboutart" then                
                
                		if str="product" then 			
							if isarray(sperStrs) then
								for each spec in sperStrs			
									nloopstr = replace(nloopstr,"["&str&":"&spec&"]",repnull(rsObj(spec)))
								next
							end if
						end if	
					
					
						select case fieldName
							case "i"
								nloopstr = replace(nloopstr,matchfield.value,i+1)
							case "link"							
								if str="aboutart" then 
									if DateArray(2,i)=1 then nloopstr = replace(nloopstr,matchfield.value,DateArray(6,i)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(DateArray(8,i),DateArray(0,i),dir(DateArray(12,i)),DateArray(13,i),DateArray(14,i)))																	
								else
									if DateArray(2,i)=1 then nloopstr = replace(nloopstr,matchfield.value,DateArray(6,i)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(DateArray(8,i),DateArray(0,i),str,DateArray(12,i),DateArray(13,i)))									
								end if							    
							case "title"
								namelen = parseArr(fieldArr)("len") 
								title=DateArray(1,i)
								if not isNul(namelen) then   								
									namelen=cint(namelen)
									if len(title)>namelen then title=left(title,namelen)&"" 
								end if	
								nloopstr = replace(nloopstr,matchfield.value,title)		
							case "titlecolor"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(9,i))
							case "istop"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(10,i))
							case "isrecommend"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(11,i))
							case "desc"
								infolen = parseArr(fieldArr)("len") : if isNul(infolen) then infolen = 200 else infolen=cint(infolen)
								nloopstr = replace(nloopstr,matchfield.value,left(filterStr(decodeHtml(DateArray(7,i)),"html"),infolen))
							case "visits"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(3,i))
							case "sortname"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(14,i))
							case "pic"
								if not isNul(DateArray(4,i)) then 
									if instr(DateArray(4,i),"http://")>0 then 
										nloopstr = replace(nloopstr,matchfield.value,DateArray(4,i))
									else
										nloopstr = replace(nloopstr,matchfield.value,DateArray(4,i))
									end if
								else
									nloopstr = replace(nloopstr,matchfield.value,"/"&sitePath&"images/nopic.gif")			
								end if
							case "date"
								timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
								select case timestyle
									case "yy-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(5,i),1))
									case "y-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(5,i),2))
									case "m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(5,i),3))
								end select
						end select
					elseif str="type" then
						select case fieldName
							case "i"
								nloopstr = replace(nloopstr,matchfield.value,i+1)
							case "link"
								nloopstr = replace(nloopstr,matchfield.value,getUrl(DateArray(2,i),lsort,DateArray(1,i),DateArray(3,i)))
							case "name"
								namelen = parseArr(fieldArr)("len")
								title=DateArray(0,i)
								if not isNul(namelen) then   								
									namelen=cint(namelen)
									if len(title)>namelen then title=left(title,namelen)&"" 
								end if	
								nloopstr = replace(nloopstr,matchfield.value,title)					
						end select					
					elseif str="about" then
						select case fieldName
							case "info"		
								infolen = parseArr(fieldArr)("len") 								
								if isNul(infolen) then 
									nloopstr = replace(nloopstr,matchfield.value,replace(decodeHtml(DateArray(0,i)),"{aspcms:page}",""))								
								else 
									infolen=cint(infolen)								
									nloopstr = replace(nloopstr,matchfield.value,left(replace(decodeHtml(DateArray(0,i)),"{aspcms:page}",""),infolen))+"…"
								end if
							case "link"
								nloopstr = replace(nloopstr,matchfield.value,getUrl(2,lsort,"",DateArray(4,i)))
							case "title"
								nloopstr = replace(nloopstr,matchfield.value,DateArray(3,i))
						end select
					elseif str="tag" then
						select case fieldName			
							case "tag"
								Dim tagStrs,tagStr,tags
								tagStrs=split(replace(replace(DateArray(0,i)," ",","),"，",","),",")
								tags=""
								for each tagStr in tagStrs
									tags=tags&"<a href=""/"&sitePath&"tag.asp?key="&tagStr&"&searchstyle=-1"">"&tagStr&"</a> "
								next
								nloopstr = replace(nloopstr,matchfield.value,tags)
						end select
					elseif str="gbook" then
						select case fieldName						
							case "i"
								nloopstr = replace(nloopstr,matchfield.value,i+1)
							case "link"
								'if rsObj(5)=1 then nloopstr = replace(nloopstr,matchfield.value,rsObj(9)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(DateArray(0,i),DateArray(0,i),showType))
							case "title"
								namelen = parseArr(fieldArr)("len") 
								title=DateArray(1,i)
								if not isNul(namelen) then   								
									namelen=cint(namelen)
									if len(title)>namelen then title=left(title,namelen)&"" 
								end if	
								nloopstr = replace(nloopstr,matchfield.value,title)	
							case "name"									
								nloopstr = replace(nloopstr,matchfield.value,repNull(DateArray(2,i)))
							case "status"									
								nloopstr = replace(nloopstr,matchfield.value,DateArray(8,i))							
							case "winfo"
								nloopstr = replace(nloopstr,matchfield.value,repNull(DateArray(4,i)))
							case "rinfo"
								nloopstr = replace(nloopstr,matchfield.value,repNull(DateArray(5,i)))
							case "wdate"
								timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
								 select case timestyle
									case "yy-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(6,i),1))
									case "y-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(6,i),2))
									case "m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(6,i),3))
								end select	
							case "rdate"
								timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
								 select case timestyle
									case "yy-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(7,i),1))
									case "y-m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(7,i),2))
									case "m-d"
										nloopstr = replace(nloopstr,matchfield.value,FormatDate(DateArray(7,i),3))
								end select	
						end select					
					end if	
				next
				loopstrTotal = loopstrTotal & nloopstr
				rsObj.movenext
			next
			set matchesfield = nothing
			content = replace(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		
		set matches = nothing
	End Function
	
	'内容页链接链接
	Function getShowLink(Byval SortID,Byval Id,Byval ShowType,Byval SortFolder,Byval GradeID)
		dim linkStr,rsObj
		if isnul(GradeID) or isnull(GradeID) then GradeID=0
		if runMode=1 and not isnul(SortFolder) then 
			if ShowType="about" then
				getShowLink="/"&sitePath&SortFolder&"/"&runstr&SortID&FileExt	
			else
				if GradeID<2 then 
					getShowLink="/"&sitePath&SortFolder&"/"&runstr&SortID&"_"&Id&FileExt
				else
					getShowLink="/"&sitePath&ShowType&"/"&"?"&SortID&"_"&Id&FileExt					
				end if
			end if	
		else
			if ShowType="about" then
				getShowLink="/"&sitePath&ShowType&"/"&runstr&SortID&FileExt	
			else			
				getShowLink="/"&sitePath&ShowType&"/"&runstr&SortID&"_"&Id&FileExt				
			end if
		end if
	End Function
	
	'替换List循环标签
	Public Function parseList(typeIds,currentPage,pageListType,keys,showType)
	    dim lenPagelist,TypeId,strPagelist,lsize,rsObj,labelRuleField,labelRulePagelist,matches,match,labelStr,loopStr,labelArr,lorder,orderStr,sql,matchesfield,sperStrs,spec,sperStr,title
		labelRule = "{aspcms:"&pageListType&"([\s\S]*?)}([\s\S]*?){/aspcms:"&pageListType&"}"
		labelRuleField = "\["&pageListType&":([\s\S]+?)\]"
		labelRulePagelist = "\["&pageListType&":pagenumber([\s\S]*?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
		
		    labelStr = match.SubMatches(0)
			loopStr = match.SubMatches(1)
			set labelArr = parseArr(labelStr)
			lsize = cint(labelArr("size")) : lorder = labelArr("order")
			if isNul(lsize) then lsize = 12 
			if isNul(lorder) then lorder = "time"
			select case lorder                     
				case "id" : orderStr =" order by IsTop,isrecommend,NewsID desc"
				case "visits" : orderStr =" order by Visits desc"
				case "time" : orderStr =" order by AddTime desc"
				case "order" : orderStr =" order by IsTop,isrecommend,NewsOrder "&orderAsc&",AddTime desc"
				case "istop" : orderStr =" and IsTop order by IsTop,isrecommend,AddTime desc"
				case "isrecommend" : orderStr =" and isrecommend order by IsTop,isrecommend,AddTime desc" 
			end select
			
			set labelArr = nothing	
			if pageListType="newslist" or pageListType="productlist" or pageListType="downlist" or pageListType="piclist"  or pageListType="searchlist"then				
				if pageListType="productlist" or pageListType="searchlist" then 
					sperStrs =conn.Exec("select SpecField from Aspcms_ProductSpecSet Order by SpecOrder Asc,SpecID", "arr")				
					if isarray(sperStrs) then
						for each spec in sperStrs
							sperStr = sperStr&","&spec
						next
					end if
				end if
			
				if isNul(keys) then
					sql="select NewsID,Title,TitleColor,ImagePath,Content,IsOutLink,Visits,AddTime,SortID,OutLink,IsTop,isrecommend,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID,(SELECT SortName FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID) "&sperStr&" from Aspcms_News where NewsStatus and SortID in ("&GetSmallestChild("Aspcms_NewsSort",typeIds)&")"&orderStr
				else		
					dim stylestr: stylestr=""
					if isnul(searchStyle) then searchStyle="-1"
					if  not "-1"=searchStyle  then stylestr=" where sortstyle="&searchStyle					
					sql="select NewsID,Title,TitleColor,ImagePath,Content,IsOutLink,Visits,Aspcms_News.AddTime,Aspcms_News.SortID,OutLink,IsTop,isrecommend,sortStyle,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID,(SELECT SortName FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID) "&sperStr&" from Aspcms_News,Aspcms_NewsSort where Aspcms_News.SortID=Aspcms_NewsSort.SortID and NewsStatus and Title like '%"&keys&"%' and Aspcms_News.SortID in (select Aspcms_NewsSort.sortid from Aspcms_NewsSort "&stylestr&") "
				end if
			elseif 	pageListType="gbooklist" then
				select case lorder           
					case "id" : orderStr =" order by FaqID desc"
					case "time" : orderStr =" order by AddTime desc"
				end select
				
				if SwitchFaqStatus=0 then 
					sql="select FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus from Aspcms_Faq "&orderStr
				else
					sql="select FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus from Aspcms_Faq where FaqStatus "&orderStr					
				end if
			end if		
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopStr)
'			die sql
			set rsObj=conn.Exec(sql,"r1")
			Dim loopstrTotal,i,nloopstr,matchfield,fieldNameArr,m,fieldName,fieldArr,namelen,infolen,timestyle,matchesPagelist,matchPagelist
			if rsObj.eof then 
			    if isNul(keys) then
				    if pageListType="gbooklist" then loopstrTotal="暂无留言！" else loopstrTotal="对不起，该分类无任何记录"
				else
				    loopstrTotal="对不起，关键字 <font color='red'>"&keys&"</font> 无任何记录"
				end if
			else
				rsObj.pagesize = lsize
				if currentPage>rsObj.pagecount then currentPage=rsObj.pagecount
				rsObj.absolutepage=currentPage
				loopstrTotal = ""
				for i = 1 to lsize
					nloopstr=loopStr
					for each matchfield in matchesfield
						fieldNameArr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
						fieldNameArr = trim(fieldNameArr)
						m = instr(fieldNameArr,chr(32))
						if  m > 0 then 
							fieldName = left(fieldNameArr,m - 1)
							fieldArr =	right(fieldNameArr,len(fieldNameArr) - m)
						else
							fieldName = fieldNameArr
							fieldArr =	""
						end if
						if pageListType="newslist" or pageListType="productlist" or pageListType="downlist" or pageListType="piclist" or pageListType="searchlist" then
						
							if pageListType="productlist" or pageListType="searchlist" then 			
								if isarray(sperStrs) then
									for each spec in sperStrs			
										nloopstr = replace(nloopstr,"["&pageListType&":"&spec&"]",repnull(rsObj(spec)))
									next
								end if
							end if	
						
							select case fieldName								
								case "i"
									nloopstr = replace(nloopstr,matchfield.value,i)
								case "link"
									if pageListType="searchlist" then 
								    	if rsObj(5)=1 then nloopstr = replace(nloopstr,matchfield.value,rsObj(9)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(rsObj(8),rsObj(0),dir(rsObj(12)),rsObj(13),rsObj(14)))								
									else
								    	if rsObj(5)=1 then nloopstr = replace(nloopstr,matchfield.value,rsObj(9)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(rsObj(8),rsObj(0),showtype,rsObj(12),rsObj(13)))										
									end if
								case "title"
									namelen = parseArr(fieldArr)("len") : if isNul(namelen) then namelen = 200 else namelen=cint(namelen)
									if len(rsObj(1))>namelen then title=left(rsObj(1),namelen)&"..." else title=rsObj(1)
									nloopstr = replace(nloopstr,matchfield.value,title)
								case "desc"
									namelen = parseArr(fieldArr)("len") : if isNul(namelen) then namelen = 100 else namelen=cint(namelen)
									dim desc
									if len(rsObj(4))>namelen then desc=left(filterStr(decodeHtml(rsObj(4)),"html"),namelen)&"..." else desc=filterStr(decodeHtml(rsObj(4)),"html")
									nloopstr = replace(nloopstr,matchfield.value,desc)															
								
								case "titlecolor"
									nloopstr = replace(nloopstr,matchfield.value,rsObj(2))
								case "istop"
									nloopstr = replace(nloopstr,matchfield.value,rsObj("istop"))
								case "isrecommend"
									nloopstr = replace(nloopstr,matchfield.value,rsObj("isrecommend"))
								case "sortname"
									if pageListType="searchlist" then 
								    	nloopstr = replace(nloopstr,matchfield.value,rsObj(15))
									else
										nloopstr = replace(nloopstr,matchfield.value,rsObj(14))
									end if
								case "info"
									infolen = parseArr(fieldArr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
									nloopstr = replace(nloopstr,matchfield.value,left(filterStr(rsObj(4),"html"),infolen))
								case "pic"
									if not isNul(rsObj(3)) then 
										if instr(rsObj(3),"http://")>0 then 
											nloopstr = replace(nloopstr,matchfield.value,rsObj(3))
										else
											nloopstr = replace(nloopstr,matchfield.value,rsObj(3))
										end if
									else
										nloopstr = replace(nloopstr,matchfield.value,"/"&sitePath&"Images/nopic.gif")
									end if
								case "visits"
									nloopstr = replace(nloopstr,matchfield.value,repNull(rsObj(6)))
								case "typename"
									nloopstr = replace(nloopstr,matchfield.value,plSort(rsObj(8)))
								case "date"
									timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),1))
										case "y-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),2))
										case "m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),3))
									end select	
							end select
						elseif pageListType="gbooklist" then	
							select case fieldName
								case "i"
									nloopstr = replace(nloopstr,matchfield.value,i)
								case "link"
								    'if rsObj(5)=1 then nloopstr = replace(nloopstr,matchfield.value,rsObj(9)) : else nloopstr = replace(nloopstr,matchfield.value,getShowLink(rsObj(8),rsObj(0),showType))
								case "title"
	
													
									namelen = parseArr(fieldArr)("len") 
									title=rsObj(1)
									if not isNul(namelen) then   								
										namelen=cint(namelen)
										if len(title)>namelen then title=left(title,namelen)&"..." 
									end if	
									nloopstr = replace(nloopstr,matchfield.value,title)	
																	
									'if len(rsObj(1))>namelen then title=left(rsObj(1),namelen)&"..." else title=rsObj(1)
									'nloopstr = replace(nloopstr,matchfield.value,title)
								case "name"									
									nloopstr = replace(nloopstr,matchfield.value,repNull(rsObj(2)))
								case "status"									
									nloopstr = replace(nloopstr,matchfield.value,rsObj(9))							
								case "winfo"
									nloopstr = replace(nloopstr,matchfield.value,repNull(rsObj(4)))
								case "rinfo"
									nloopstr = replace(nloopstr,matchfield.value,repNull(rsObj(5)))
								case "wdate"
									timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(6),1))
										case "y-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(6),2))
										case "m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),3))
									end select	
								case "rdate"
									timestyle = parseArr(fieldArr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),1))
										case "y-m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),2))
										case "m-d"
											nloopstr = replace(nloopstr,matchfield.value,FormatDate(rsObj(7),3))
									end select	
							end select
						
						end if
					next
					loopstrTotal = loopstrTotal & nloopstr
					rsObj.movenext
					if rsObj.eof then exit for
				next
			end if
			content = replace(content,match.value,loopstrTotal)
			regExpObj.Pattern = labelRulePagelist
			set matchesPagelist = regExpObj.Execute(content)
			for each matchPagelist in matchesPagelist
				if rsObj.pagecount=0 then
					content = replace(content,matchPagelist.value,"")
				else
					lenPagelist = parseArr(matchPagelist.SubMatches(0))("len")
					if isNul(lenPagelist) then lenPagelist = 10 else lenPagelist = cint(lenPagelist)
					if isExistStr(TypeIds,",") then TypeId=split(TypeIds,",")(0) : else TypeId=TypeIds
					strPagelist = pageNumberLinkInfo(currentPage,lenPagelist,rsObj.pagecount,pageListType,TypeId)
					content = replace(content,matchPagelist.value,strPagelist)
				end if
			next
			set matchesPagelist = nothing
			set matchesfield = nothing
			strDictionary.removeAll
		next
		set matches = nothing
	End Function
	

	'解析友情链接
	Public Function parseLinkList()
		if not isExistStr(content,"{aspcms:linklist") then Exit Function
		dim match,matches,matchfield,matchesfield
		dim labelAttrLinklist,loopstrLinklist,loopstrLinklistNew,loopstrTotal
		dim vtype,vnum,whereStr,linkArray
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,labelRuleField
		dim m,namelen,deslen,m_des
		labelRule="{aspcms:linklist([\s\S]*?)}([\s\S]*?){/aspcms:linklist}"
		labelRuleField="\[linklist:([\s\S]+?)\]"
		regExpObj.Pattern=labelRule
		set matches=regExpObj.Execute(content)
		for each match in matches
			labelAttrLinklist=match.SubMatches(0)
			loopstrLinklist=match.SubMatches(1)
			vtype=parseArr(labelAttrLinklist)("type")
			if isNul(vtype) then vtype=0
			select case vtype
				case "font" : whereStr=chr(32)&"LinkType=0 and LinkStatus"&chr(32)
				case "pic" : whereStr=chr(32)&"LinkType=1 and LinkStatus"&chr(32)
				case else : whereStr=chr(32)&"LinkStatus"&chr(32)
			end select
			linkArray=conn.Exec("select LinkText,ImageURL,LinkURL,LinkDesc from Aspcms_Links  where "&whereStr&" order by LinkOrder asc","arr")
			if not isarray(linkArray) then  vnum=-1  else vnum=ubound(linkArray,2)
			regExpObj.Pattern=labelRuleField
			set matchesfield=regExpObj.Execute(loopstrLinklist)
			loopstrTotal=""
			for i=0 to vnum
				loopstrLinklistNew=loopstrLinklist
				for each matchfield in matchesfield
					fieldNameAndAttr=regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr=trimOuter(fieldNameAndAttr)
					m=instr(fieldNameAndAttr,chr(32))
					if m > 0 then 
						fieldName=left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName=fieldNameAndAttr
						fieldAttr =	""
					end if
					select case fieldName
						case "name"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(0,i))
						case "link"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(2,i))
						case "pic"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(1,i))
						case "des"
							m_des=decodeHtml(linkArray(3,i)):deslen=parseArr(fieldAttr)("len")
							if isNul(deslen) then deslen=100
							if len(m_des) > clng(deslen) then  m_des=left(m_des,clng(deslen)-1)&".."
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,m_des)
						case "i"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,i+1)
					end select
				next
				loopstrTotal=loopstrTotal&loopstrLinklistNew
			next
			set matchesfield=nothing
			content=replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches=nothing
	End Function

	'解析if
	Public Function parseIf()
		if not isExistStr(content,"{if:") then Exit Function
		dim matchIf,matchesIf,strIf,strThen,strThen1,strElse1,labelRule2,labelRule3
		dim ifFlag,elseIfArray,elseIfSubArray,elseIfArrayLen,resultStr,elseIfLen,strElseIf,strElseIfThen,elseIfFlag
		labelRule="{if:([\s\S]+?)}([\s\S]*?){end\s+if}":labelRule2="{elseif":labelRule3="{else}":elseIfFlag=false
		regExpObj.Pattern=labelRule
		set matchesIf=regExpObj.Execute(content)
		for each matchIf in matchesIf 
			strIf=matchIf.SubMatches(0):strThen=matchIf.SubMatches(1)
			if instr(strThen,labelRule2)>0 then
				elseIfArray=split(strThen,labelRule2):elseIfArrayLen=ubound(elseIfArray):elseIfSubArray=split(elseIfArray(elseIfArrayLen),labelRule3)
				resultStr=elseIfSubArray(1)
				Execute("if "&strIf&" then resultStr=elseIfArray(0)")
				for elseIfLen=1 to elseIfArrayLen-1
					strElseIf=getSubStrByFromAndEnd(elseIfArray(elseIfLen),":","}","")
					strElseIfThen=getSubStrByFromAndEnd(elseIfArray(elseIfLen),"}","","start")
					Execute("if "&strElseIf&" then resultStr=strElseIfThen")
					Execute("if "&strElseIf&" then elseIfFlag=true else  elseIfFlag=false")
					if elseIfFlag then exit for
				next
				Execute("if "&getSubStrByFromAndEnd(elseIfSubArray(0),":","}","")&" then resultStr=getSubStrByFromAndEnd(elseIfSubArray(0),""}"","""",""start""):elseIfFlag=true")
				content=replace(content,matchIf.value,resultStr)
			else 
				if instr(strThen,"{else}")>0 then 
					strThen1=split(strThen,labelRule3)(0)
					strElse1=split(strThen,labelRule3)(1)
					Execute("if "&strIf&" then ifFlag=true else ifFlag=false")
					if ifFlag then content=replace(content,matchIf.value,strThen1) else content=replace(content,matchIf.value,strElse1)
				else		
					Execute("if "&strIf&" then ifFlag=true else ifFlag=false")
					if ifFlag then content=replace(content,matchIf.value,strThen) else content=replace(content,matchIf.value,"")
				end if
			end if
			elseIfFlag=false
		next
		set matchesIf=nothing
	End Function
	
	
	'解析留言
	Public Function parseGbook()
		Dim gbook
		gbook="<div id=""faqbox"">"&vbcrlf& _
		"<form action=""save.asp?action=add"" method=""post"">"&vbcrlf& _
		"    <div class=""faqline"">"&vbcrlf& _
		"        <span class=""faqtit"">问题：</span>"&vbcrlf& _
		"        <input name=""FaqTitle"" type=""text"" /><font color=""#FF0000"">*</font>"&vbcrlf& _
		"    </div>    "&vbcrlf& _
		"    <div class=""Content"">"&vbcrlf& _
		"        <span class=""faqtit"">内容：</span>"&vbcrlf& _
		"        <textarea name=""Content"" cols=""60"" rows=""5""></textarea><font color=""#FF0000"">*</font>"&vbcrlf& _
		"    </div>"&vbcrlf& _
		"   <div class=""faqline"">"&vbcrlf& _
		"        <span class=""faqtit"">联系人：</span>"&vbcrlf& _
		"        <input name=""Contact"" type=""text"" /><font color=""#FF0000"">*</font>"&vbcrlf& _
		"    </div>"&vbcrlf& _
		"   <div class=""faqline"">"&vbcrlf& _
		"        <span class=""faqtit"">联系方式：</span>"&vbcrlf& _
		"        <input name=""ContactWay"" type=""text"" /> <font color=""#FF0000"">*</font> 请注明是手机、电话、QQ、Email,方便我们和您联系"&vbcrlf& _
		"    </div>"&vbcrlf& _
		"  <div class=""faqline"">"&vbcrlf& _
		"        <span class=""faqtit"">验证码：</span>"&vbcrlf& _
		"        <input name=""code"" type=""text"" class=""login_verification"" id=""verification"" size=""6"" maxlength=""6""/><font color=""#FF0000"">*</font>"&vbcrlf& _
		"        <img src=""../inc/checkcode.asp"" alt=""看不清验证码?点击刷新!"" onClick=""this.src='../inc/checkcode.asp'"" />"&vbcrlf& _
		"    </div>"&vbcrlf& _
		"   <div class=""faqline"">"&vbcrlf& _
		"        <span class=""faqtit"">&nbsp;</span>"&vbcrlf& _
		"        <input type=""submit"" value="" 提交 ""/>"&vbcrlf& _
		"    </div>"&vbcrlf& _
		"</form>"&vbcrlf& _
		"</div>"&vbcrlf
		content=replaceStr(content,"{aspcms:gbook}",gbook)
	End Function
	
	
	Function getSlide
		'"var texts='"&replace(slideTexts,",","|")&"';"&vbcrlf& _
		Dim Str,sTexts
		if slideTextStatus then 
			sTexts="var texts='"&replace(replace(slideTexts,",","|")," ","")&"';"
		else
			sTexts="var texts ;"		
		end if
		
		Str="<SCRIPT language=JavaScript type=text/javascript>"&vbcrlf& _		
		"var swf_width='"&slideWidth&"';"&vbcrlf& _
		"var swf_height='"&slideHeight&"';"&vbcrlf& _
		"var files='"&replace(replace(slideImgs,",","|")," ","")&"';"&vbcrlf& _
		"var links='"&replace(replace(slideLinks,",","|")," ","")&"';"&vbcrlf& _
		sTexts&vbcrlf& _
		"document.write('<object classid=""clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"" codebase=""http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"" width=""'+ swf_width +'"" height=""'+ swf_height +'"">');"&vbcrlf& _
		"document.write('<param name=""movie"" value=""/"&sitePath&"flash/slideflash.swf""><param name=""quality"" value=""high"">');"&vbcrlf& _
		"document.write('<param name=""menu"" value=""false""><param name=wmode value=""opaque"">');"&vbcrlf& _
		"document.write('<param name=""FlashVars"" value=""bcastr_file='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'"">');"&vbcrlf& _
		"document.write('<embed src=""/"&sitePath&"flash/slideflash.swf"" wmode=""opaque"" FlashVars=""bcastr_file='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'& menu=""false"" quality=""high"" width=""'+ swf_width +'"" height=""'+ swf_height +'"" type=""application/x-shockwave-flash"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" />'); document.write('</object>'); "&vbcrlf& _
		"</SCRIPT>"		
		getSlide=Str
	End Function
	
	Function getFloatAD
		if adStatus=0 then exit function
		Dim Str
		Str="<div id=""img"" style=""position:absolute;""> <a href="""&adLink&""" target=""_blank""> <img src="""&adImagePath&""" width="""&adImgWidth&""" height="""&adImgHeight&""" border=""0""></a> </div>"&vbcrlf& _
		"<script type=""text/javascript"" language=""JavaScript""> "&vbcrlf& _
		"<!-- "&vbcrlf& _
		"var xPos = 20; "&vbcrlf& _
		"var yPos = document.body.clientHeight; "&vbcrlf& _
		"var step = 1; "&vbcrlf& _
		"var delay = 30; "&vbcrlf& _
		"var height = 0; "&vbcrlf& _
		"var Hoffset = 0; "&vbcrlf& _
		"var Woffset = 0; "&vbcrlf& _
		"var yon = 0; "&vbcrlf& _
		"var xon = 0; "&vbcrlf& _
		"var pause = true; "&vbcrlf& _
		"var interval; "&vbcrlf& _
		"img.style.top = yPos; "&vbcrlf& _
		"function changePos() { "&vbcrlf& _
		"width = document.body.clientWidth; "&vbcrlf& _
		"height = document.body.clientHeight; "&vbcrlf& _
		"Hoffset = img.offsetHeight; "&vbcrlf& _
		"Woffset = img.offsetWidth; "&vbcrlf& _
		"img.style.left = xPos + document.body.scrollLeft; "&vbcrlf& _
		"img.style.top = yPos + document.body.scrollTop; "&vbcrlf& _
		"if (yon) { "&vbcrlf& _
		"yPos = yPos + step; "&vbcrlf& _
		"} "&vbcrlf& _
		"else { "&vbcrlf& _
		"yPos = yPos - step; "&vbcrlf& _
		"} "&vbcrlf& _
		"if (yPos < 0) { "&vbcrlf& _
		"yon = 1; "&vbcrlf& _
		"yPos = 0;"&vbcrlf& _
		"} "&vbcrlf& _
		"if (yPos >= (height - Hoffset)) { "&vbcrlf& _
		"yon = 0; "&vbcrlf& _
		"yPos = (height - Hoffset); "&vbcrlf& _
		"} "&vbcrlf& _
		"if (xon) { "&vbcrlf& _
		"xPos = xPos + step; "&vbcrlf& _
		"} "&vbcrlf& _
		"else { "&vbcrlf& _
		"xPos = xPos - step; "&vbcrlf& _
		"} "&vbcrlf& _
		"if (xPos < 0) { "&vbcrlf& _
		"xon = 1; "&vbcrlf& _
		"xPos = 0;"&vbcrlf& _
		"} "&vbcrlf& _
		"if (xPos >= (width - Woffset)) { "&vbcrlf& _
		"xon = 0; "&vbcrlf& _
		"xPos = (width - Woffset); "&vbcrlf& _
		"} "&vbcrlf& _
		"} "&vbcrlf& _
		"function ad() { "&vbcrlf& _
		"img.visibility = ""visible""; "&vbcrlf& _
		"interval = setInterval('changePos()', delay); "&vbcrlf& _
		"} "&vbcrlf& _
		"ad(); "&vbcrlf& _
		"//For more,visit:www.helpor.net "&vbcrlf& _
		"--> "&vbcrlf& _
		"</script>"&vbcrlf	
		getFloatAD=Str
	End Function
	
	Function getOnlineservice
		if serviceStatus=1 then
			if serviceStyle=1 then getOnlineservice=getqqkf1
			if serviceStyle=2 then getOnlineservice=getqqkf2
		end if
	End Function
		
	Function getKf
		if servicekfStatus=1 then
			getKf=servicekf
		end if	
	End Function
	
	
	
	Function getqqkf1
		Dim Str	,i,tempstr
		Str="<LINK rev=stylesheet href=""/"&sitePath&"Images/qq/qqkf1/default.css"" type=text/css rel=stylesheet>"&vbcrlf& _
		"<DIV id=kefu_pannel style=""Z-INDEX: 30000; FILTER: alpha(opacity=85); LEFT: 0px; POSITION: absolute; TOP: 120px"">"&vbcrlf& _
		"<TABLE cellSpacing=0 cellPadding=0 border=0>"&vbcrlf& _
		"<THEAD id=kefu_pannel_top>"&vbcrlf& _
		"<TR>"&vbcrlf& _
		"<TH class=kefu_Title><SPAN class=kefu_shut id=kefu_ctrl onclick=HideKefu()></SPAN>"&vbcrlf& _
		"<H2 class=txtCut>在线客服</H2></TH></TR></THEAD>"&vbcrlf& _
		"<TBODY id=kefu_pannel_mid>"&vbcrlf& _
		"<TR>"&vbcrlf& _
		"<TD height=3></TD></TR>"&vbcrlf& _
		"<TR>"&vbcrlf& _
		"<TD>"&vbcrlf

		if not isnul(serviceQQ) then
			tempstr = split(serviceQQ," ")
			for i=0 to ubound(tempstr)		
				Str=Str&" <DIV class=kefu_box onmouseover=""this.className='kefu_boxOver'"" onmouseout=""this.className='kefu_box'""><SPAN class=kefu_image><IMG src=""/"&sitePath&"Images/qq/qqkf1/icon_person_stat_online.gif""></SPAN><A class=kefu_Type_qq href=""tencent://message/?uin="&trim(tempstr(i))&"&amp;Menu=yes""><img border=""0"" src=""http://wpa.qq.com/pa?p=2:"&trim(tempstr(i))&":41 &r=0.8817731731823399"" alt=""点击这里给我发消息"" title=""点击这里给我发消息""></A></DIV>"&vbcrlf
			next
		end if
		
		if not isnul(serviceWangWang) then		
			tempstr = split(serviceWangWang," ")
			for i=0 to ubound(tempstr)	
				Str=Str&"<DIV class=kefu_box onmouseover=""this.className='kefu_boxOver'"" onmouseout=""this.className='kefu_box'""><SPAN class=kefu_image><IMG src=""/"&sitePath&"Images/qq/qqkf1/icon_person_stat_online.gif""></SPAN><A target=""_blank"" class=kefu_Type_msn href=""http://amos1.taobao.com/msg.ww?v=2&uid="&trim(tempstr(i))&"&s=1""><img border=""0"" src=""http://amos1.taobao.com/online.ww?v=2&uid="&trim(tempstr(i))&"&s=1"" alt=""点击这里给我发消息"" /></A></DIV>"&vbcrlf		
			next
		end if		
		Str=Str&"</TD></TR>"&vbcrlf& _
		"<TR>"&vbcrlf& _
		"<TD height=3></TD></TR></TBODY>"&vbcrlf& _
		"<TFOOT id=kefu_pannel_btm>"&vbcrlf& _
		"<TR style=""CURSOR: hand"" onclick=""parent.location='"&serviceContact&"';"">"&vbcrlf& _
		"<TD class=kefu_other></TD></TR></TFOOT></TABLE></DIV>"&vbcrlf& _
		"<SCRIPT language=JavaScript src=""/"&sitePath&"Images/qq/qqkf1/qqkf.js""></SCRIPT>"&vbcrlf
		getqqkf1=Str
	End Function
	
	
	Function getqqkf2
		Dim Str	,i,tempstr
		Str="<LINK rev=stylesheet href=""/"&sitePath&"Images/qq/qqkf2/kf.css"" type=text/css rel=stylesheet>"&vbcrlf& _
		"<div onmouseout=""toSmall()"" onmouseover=""toBig()"" id=""qq_Kefu"" style=""top: 1363.9px; left: -143px; position: absolute; "">"&vbcrlf& _
		"  <table cellspacing=""0"" cellpadding=""0"" border=""0"">"&vbcrlf& _
		"    <tbody><tr>"&vbcrlf& _
		"      <td><table cellspacing=""0"" cellpadding=""0"" border=""0"">"&vbcrlf& _
		"          <tbody>"&vbcrlf& _
		"          <tr>"&vbcrlf& _
		"          	<td background=""/"&sitePath&"Images/qq/qqkf2/Kf_bg03_01.gif"" height=""32""></td>"&vbcrlf& _
		"          </tr>"&vbcrlf& _
		"          <tr>"&vbcrlf& _
		"            <td background=""/"&sitePath&"Images/qq/qqkf2/Kf_bg03_02.gif"" align=""left""  width=""143"">"&vbcrlf& _
		"            <div class=""kfbg"">"&vbcrlf
		if not isnul(serviceQQ) then
			tempstr = split(serviceQQ," ")
			for i=0 to ubound(tempstr)		
				Str=Str&" <DIV class=kefu_box onmouseover=""this.className='kefu_boxOver'"" onmouseout=""this.className='kefu_box'""><A class=kefu_Type_qq href=""tencent://message/?uin="&trim(tempstr(i))&"&amp;Menu=yes""><img border=""0"" src=""http://wpa.qq.com/pa?p=2:"&trim(tempstr(i))&":41 &r=0.8817731731823399"" alt=""点击这里给我发消息"" title=""点击这里给我发消息""></A></DIV>"&vbcrlf
			next
		end if
		
		if not isnul(serviceWangWang) then		
			tempstr = split(serviceWangWang," ")
			for i=0 to ubound(tempstr)	
				Str=Str&"<DIV class=kefu_box onmouseover=""this.className='kefu_boxOver'"" onmouseout=""this.className='kefu_box'""><A target=""_blank"" class=kefu_Type_msn href=""http://amos1.taobao.com/msg.ww?v=2&uid="&trim(tempstr(i))&"&s=1""><img border=""0"" src=""http://amos1.taobao.com/online.ww?v=2&uid="&trim(tempstr(i))&"&s=1"" alt=""点击这里给我发消息"" /></A></DIV>"&vbcrlf		
			next
		end if	

         Str=Str&"</div>   "&vbcrlf& _
		"            </td>"&vbcrlf& _
		"          </tr>"&vbcrlf& _
		"          <tr  style=""CURSOR: hand"" onclick=""parent.location='"&serviceContact&"';"" >"&vbcrlf& _
		"            <td height=""46"" background=""/"&sitePath&"Images/qq/qqkf2/Kf_bg03_03.gif""><div class=""Kefu_Work""></div></td>"&vbcrlf& _
		"          </tr>"&vbcrlf& _
		"        </tbody></table></td>"&vbcrlf& _
		"      <td class=""kfbut"" width=""27"" rowspan=""3"" class=""Kefu_Little""></td>"&vbcrlf& _
		"    </tr>"&vbcrlf& _
		"  </tbody></table>"&vbcrlf& _
		"</div>"&vbcrlf& _
		"<script src=""/"&sitePath&"Images/qq/qqkf2/kefu.js"" type=""text/javascript""></script>"&vbcrlf
		getqqkf2=Str
	End Function	
	
	
	
	Public Function parsePrevAndNext(Id,SortID)
		Dim rsObjPrev,rsObjNext,tempStr,linkStr
		set rsObjPrev = conn.Exec("select top 1 NewsID,Title,SortStyle,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID from Aspcms_News,Aspcms_NewsSort where Aspcms_News.SortID=Aspcms_NewsSort.SortID and NewsStatus and NewsID<"&Id&" and Aspcms_News.SortID="&SortID&" order by NewsID desc","r1")
		if rsObjPrev.bof then 
			linkStr ="没有了!"
		else
			linkStr=getShowLink(SortID,rsObjPrev(0),dir(rsObjPrev(2)),rsObjPrev(3),rsObjPrev(4))
			'linkStr="/"&sitePath&dir(rsObjPrev(2))&"/"&runstr&SortID&"_"&rsObjPrev(0)&FileExt
			linkStr="<a href="""&linkStr&""">"&rsObjPrev(1)&"</a>"
		end if
		content = replace(content,"{aspcms:prev}",linkStr)
		rsObjPrev.close : set rsObjPrev = nothing
		
		set rsObjNext = conn.Exec("select top 1 NewsID,Title,SortStyle,(SELECT SortFolder FROM Aspcms_NewsSort WHERE SortID=Aspcms_News.SortID),GradeID from Aspcms_News,Aspcms_NewsSort where Aspcms_News.SortID=Aspcms_NewsSort.SortID and NewsStatus and NewsID>"&Id&" and Aspcms_News.SortID="&SortID&"","r1")
		if rsObjNext.eof then 
			linkStr = "没有了!"
		else			
			linkStr=getShowLink(SortID,rsObjNext(0),dir(rsObjNext(2)),rsObjNext(3),rsObjNext(4))
			'linkStr="/"&sitePath&dir(rsObjNext(2))&"/"&runstr&SortID&"_"&rsObjNext(0)&FileExt
			linkStr="<a href="""&linkStr&""">"&rsObjNext(1)&"</a>"
		end if	
		content = replace(content,"{aspcms:next}",linkStr)
		rsObjNext.close	: set rsObjNext = nothing
	End Function
	
	Function getArrt(str,tag,arr)
		Dim labelRule,match,matches
		labelRule = "\["&str&":"&tag&"([\s\S]*?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
			getArrt = parseArr(match.SubMatches(0))(arr)			
		next
		set matches = nothing
		strDictionary.removeAll
	End Function
	
	Function getTopType(SortID)
		Dim tempStr,rsObj
		set rsObj = conn.Exec("select SortName,ParentID,SortID,sortStyle,sortUrl,SortFolder from Aspcms_NewsSort where SortID="&SortID&"","r1")
			tempStr=tempStr&"<a href="""&getUrl(rsObj(3),rsObj(2),rsObj(4),rsObj(5))&""">"&rsObj(0)&"</a>,"
			if rsObj(1)<>0 then tempStr=tempStr&getTopType(rsObj(1))
		rsObj.close : set rsObj=nothing
		getTopType=tempStr
	End Function 
	
	
	Public Function parsePosition(SortID)
		Dim rsObjSmalltype
		set rsObjSmalltype = conn.Exec("select SortName from Aspcms_NewsSort where SortID="&SortID&"","r1")
			content = replace(content,"{aspcms:sortname}",rsObjSmalltype(0))
		rsObjSmalltype.close : set rsObjSmalltype=nothing		
		if not isExistStr(content,"{aspcms:position") then Exit Function
		dim match,matches,matchfield,matchesfield,arrlen
		dim labelAttrLinklist,loopstrLinklist,loopstrLinklistNew,loopstrTotal
		dim vtype,vnum,whereStr,linkArray
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,labelRuleField
		dim m,namelen,deslen,m_des
		labelRule="{aspcms:position([\s\S]*?)}([\s\S]*?){/aspcms:position}"
		labelRuleField="\[position:([\s\S]+?)\]"
		regExpObj.Pattern=labelRule
		set matches=regExpObj.Execute(content)
		for each match in matches
		
			linkArray=Split(getTopType(SortID),",")
			arrlen=ubound(linkArray)
			for i=0 to arrlen-1				
				loopstrLinklist=match.SubMatches(1)
				regExpObj.Pattern=labelRuleField
				set matchesfield=regExpObj.Execute(loopstrLinklist)
				loopstrLinklistNew=loopstrLinklist
				for each matchfield in matchesfield
					fieldNameAndAttr=regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr=trimOuter(fieldNameAndAttr)				
					
					m=instr(fieldNameAndAttr,chr(32))
					'die m
					if m > 0 then 
						fieldName=left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName=fieldNameAndAttr
						fieldAttr =	""
					end if					
					select case fieldName
						case "link"
							loopstrLinklistNew=replaceStr(loopstrLinklistNew,matchfield.value,linkArray(arrlen-1-i))					
					end select
				next
				loopstrTotal=loopstrTotal&loopstrLinklistNew
			next				
			set matchesfield=nothing
			content=replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches=nothing 		
	End Function
	
	Public Function parseHtml()		
		parseTopAndFoot()
		parseAuxiliaryTemplate() 
	End Function
	
	Public Function parseCommon()
		parseGlobal()
		parseNavList("")
		parseLinkList()
		parseLoop("type")
		parseLoop("about")
		parseLoop("news")
		parseLoop("down")
		parseLoop("pic")
		parseLoop("product")	
		parseLoop("gbook")	
		parseLoop("tag")			
		content=replaceStr(content,"{aspcms:keys}",keys)
		content=replaceStr(content,"{aspcms:searchstyle}",searchStyle)
		parseGbook()
		parseIf()
	End Function
	
	
	
	
	
	

	
End Class
%>