<!--#include file="../FCKeditor/fckeditor.asp" -->
<!--#include file="../_make/AspCms_MakeHtmlFun.asp" -->
<%
CheckAdmin()

'die keyword
'�жϲ���
Select  case action
	case "addbase" : EditBase
	case "editbase" : EditBase
	
	case "addnews" : AddNews
	case "editnews" : EditNews

	case "adddown" : AddDown
	case "editdown" : EditDown
		
	case "addproduct" : AddProduct
	case "editproduct" : EditProduct
	
	case "delspec" : DelSpec
	case "addspec" : AddSpec
	case "savespec" :SaveSpec	
	
	case "enable" :Enable
	case "notEnabled" :NotEnabled
	
	case "istop" : ToTop
	case "notop" : NoTop
	
	case "isrecommend" : ToRecommend
	case "norecommend" : NoRecommend
	
	case "uorder" : UpdateOrder
	
	case "del" : DelContent
End Select



'�������ID�������ؼ��ʣ�ҳ��������
Dim SortID,keyword,page,order,pic

SortID =getForm("sort","get")	
keyword=getForm("keyword","post")
if isnul(keyword) then keyword=getForm("keyword","get")
page=getForm("page","get")
order=getForm("order","get")
pic=getForm("pic","get")

'Die getForm("sort","get")
'if isnul(SortID) then alertMsgAndGo "SortΪ��","-1"


Dim styleName
if pic="1" then 
	styleName="ͼƬ"
else
	styleName="����"
end if

Sub MakeNewContent(ac,SortID)
	dim sortRsObj
	set sortRsObj=Conn.Exec("select SortFolder,sortStyle from Aspcms_NewsSort where  SortID="&SortID,"r1")
	dim newsSortFolder
	if isnul(sortRsObj(0)) then 
		newsSortFolder=dir(sortRsObj(1))
	end if
	
'	die isnul(sortRsObj(0))	
'	die sortRsObj(1)&dir(sortRsObj(1))
'	die newsSortFolder&"AA"
	if runMode=1 then 
		if ac="add" then
			makeContentById Conn.Exec("select @@identity","r1")(0),SortID,dir(sortRsObj(1))	
		elseif ac="edit" then
			makeContentById NewsID,SortID,dir(sortRsObj(1))
		elseif ac="about" then			
			makeAboutBySortid SortID,dir(sortRsObj(1))
		end if
	end if
	sortRsObj.close : set sortRsObj=nothing
End Sub



Sub UpdateOrder
	Dim ids				:	ids=split(getForm("nid","post"),",")
	Dim orders		:	orders=split(getForm("order","post"),",")
	If Ubound(ids)=-1 Then 	'��ֹ��ֵΪ��ʱ�±�Խ��
		ReDim ids(0)
		ids(0)=""
	End If	
	
	If Ubound(orders)=-1 Then
		ReDim orders(0)
		orders(0)=0
	End If
	Dim i
	
	For i=0 To Ubound(ids)		
		Conn.Exec "update AspCms_News Set NewsOrder="&trim(orders(i))&" Where NewsID="&trim(ids(i)),"exe"		
	Next
	
	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	alertMsgAndGo "��������ɹ�","?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub


Sub DelContent
	Dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "��ѡ��Ҫɾ��������","-1"
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
		
	Dim rsObj : set rsObj=conn.Exec("select AspCms_News.SortID,NewsID,SortStyle from AspCms_News,Aspcms_NewsSort where NewsID in("&id&") and AspCms_News.SortID=Aspcms_NewsSort.SortID","r1")	
	Dim filePath
	do while not rsObj.eof
		filePath="/"&sitePath&Dir(rsObj(2))&"/"&rsObj(0)&"_"&rsObj(1)&FileExt
		if isExistFile(filePath)then delFile filePath
		rsObj.movenext
	loop
	rsObj.close : set rsObj=nothing
	Conn.Exec "delete * from AspCms_News where NewsID in("&id&")","exe"
	alertMsgAndGo "ɾ���ɹ�","?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub


'���幫�ñ���
Dim NewsID,Title,Title2,TitleColor,IsOutLink,OutLink,Author,NewsSource,NewsTag,Content,NewsStatus,IsTop,Isrecommend,IsImageNews,NewsOrder,AddTime,Visits,ImagePath,PagePath,PageTitle,PageKey,PageDesc,ID,DownURL,spec,Exclusive,GradeID
ID = getForm("id","both")

Sub AddDown
	SortID=getForm("SortID","post")
	Title=getForm("Title","post")
	Content=encodeHtml(getForm("Content","post"))
	NewsStatus=getCheck(getForm("NewsStatus","post"))
	NewsTag=getForm("NewsTag","post")	
	DownURL=getForm("ImagePath","post")
	AddTime=now()
	PageDesc=left(getForm("PageDesc","post"),255)
	
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
	
	if isnul(Title) then alertMsgAndGo "�������Ʋ���Ϊ��","-1"
	Conn.Exec"insert into Aspcms_News(SortID,Title,Content,NewsStatus,NewsTag,DownURL,AddTime,PageDesc,Exclusive,GradeID) values("&SortID&",'"&Title&"','"&Content&"',"&NewsStatus&",'"&NewsTag&"','"&DownURL&"','"&AddTime&"','"&PageDesc&"','"&Exclusive&"',"&GradeID&")","exe"
	MakeNewContent "add",SortID
	alertMsgAndGo "���ӳɹ�","?sort="&SortID
End SuB

Sub EditDown	
	NewsID=getForm("NewsID","post")
	Title=getForm("Title","post")
	Content=encodeHtml(getForm("Content","post"))
	NewsStatus=getCheck(getForm("NewsStatus","post"))
	NewsTag=getForm("NewsTag","post")	
	DownURL=getForm("ImagePath","post")
	PageDesc=left(getForm("PageDesc","post"),255)
	
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	
	Conn.Exec"update Aspcms_News set Title='"&Title&"',Content='"&Content&"',NewsStatus="&NewsStatus&",NewsTag='"&NewsTag&"',DownURL='"&DownURL&"',PageDesc='"&PageDesc&"',Exclusive='"&Exclusive&"',GradeID="&GradeID&" where NewsID="&NewsID,"exe"
	MakeNewContent "edit",SortID
	alertMsgAndGo "�޸ĳɹ�","AspCms_DownList.asp?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End SuB

Sub getContent
	if not isnul(ID) then		
		Dim rs : Set rs = Conn.Exec("select * from Aspcms_news where NewsID="&ID,"r1")
		if not rs.eof then
			SortID=rs("SortID")
			NewsID=rs("NewsID")
			Title=rs("Title")
			Title2=rs("Title2")
			TitleColor=rs("TitleColor")
			IsOutLink=rs("IsOutLink")
			OutLink=rs("OutLink")
			Author=rs("Author")
			NewsSource=rs("NewsSource")
			NewsTag=rs("NewsTag")
			Content=decodeHtml(rs("Content"))
			NewsStatus=rs("NewsStatus")
			IsTop=rs("IsTop")
			Isrecommend=rs("Isrecommend")
			IsImageNews=rs("IsImageNews")
			NewsOrder=rs("NewsOrder")
			AddTime=rs("AddTime")
			Visits=rs("Visits")
			ImagePath=rs("ImagePath")
			PagePath=rs("PagePath")
			PageTitle=rs("PageTitle")
			PageKey=rs("PageKey")
			PageDesc=rs("PageDesc")
			ID=rs("NewsID")
			DownURL=rs("DownURL")			
			Exclusive=rs("Exclusive")		
			GradeID=rs("GradeID")
		end if
	else		
		alertMsgAndGo "û��������¼","-1"
	end if
End Sub

Sub getBase
	Dim rs		:	Set rs=Conn.Exec("select SortName from Aspcms_NewsSort where SortID="&sortID,"r1")	
	if not rs.eof then
		Title=rs(0)	
		action ="addbase"
		Set rs = Conn.Exec("select * from Aspcms_news where SortID="&sortID,"r1")
		if not rs.eof then
			Title2=rs("Title2")
			Content=decodeHtml(rs("Content"))
			PageTitle=rs("PageTitle")
			PageKey=rs("PageKey")
			PageDesc=rs("PageDesc")
			action ="editbase"
		end if
	else
		alertMsgAndGo"û���������","-1"
	end if
	rs.Close	:	set rs=Nothing
End Sub


Sub EditBase
	SortID=getForm("SortID","post")
	Title=getForm("Title","post")	
	Title2=getForm("Title2","post")
	Content=encodeHtml(getForm("Content","post"))
	'die Content
	PageTitle=getForm("PageTitle","post")
	PageKey=getForm("PageKey","post")
	PageDesc=left(getForm("PageDesc","post"),255)	
	'if isnul(Title) then alertMsgAndGo"����д��������","-1"
	'if isurl(Content) then alertMsgAndGo"����д���ӵ�ַ","-1"	
	Dim sql,msg 	
	if action ="addbase" then
		sql ="insert into Aspcms_News(SortID,Title,Title2,Content,PageTitle,PageKey,PageDesc,AddTime,Visits) values('"&SortID&"','"&Title&"','"&Title2&"','"&Content&"','"&PageTitle&"','"&PageKey&"','"&PageDesc&"',now(),0)"
		msg="���ӳɹ�"
		Conn.Exec sql,"exe"	
		MakeNewContent "about",SortID
		alertMsgAndGo msg,"AspCms_BaseAdd.asp?sort="&sortID
	elseif action ="editbase" then
		sql = "update Aspcms_News set Title2='"&Title2&"',Content='"&Content&"',PageTitle='"&PageTitle&"',PageKey='"&PageKey&"',PageDesc='"&PageDesc&"' where SortID="&SortID
		msg="����ɹ�"
		Conn.Exec sql,"exe"	
		MakeNewContent "about",SortID
		alertMsgAndGo msg,"AspCms_BaseAdd.asp?sort="&sortID
	end if	
End Sub

Sub AddProduct
	SortID=getForm("SortID","post")
	Title=getForm("Title","post")
	spec=split(getForm("spec","post"),",")
	ImagePath=getForm("ImagePath","post")
	Content=encodeHtml(getForm("Content","post"))
	NewsStatus=getCheck(getForm("NewsStatus","post"))
	NewsTag=getForm("NewsTag","post")	
	PageDesc=left(getForm("PageDesc","post"),255)
	
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
	
	 
	if isnul(Title) then alertMsgAndGo "��Ʒ���Ʋ���Ϊ��","-1"
	if isnul(ImagePath) then alertMsgAndGo "���ϴ�ͼƬ","-1"
	if isnul(NewsStatus) then NewsStatus=0
	 
	Dim specStr	: specStr=""
	Dim valueStr	: valueStr=""
	Dim i	:i=0
	Dim rsObj	:	Set rsObj=Conn.Exec("select SpecField from Aspcms_ProductSpecSet order by SpecOrder,SpecID","r1")
	Do While not rsObj.Eof 		
		specStr = specStr&","&rsObj(0)
		valueStr = valueStr&",'"&trim(spec(i))&"'"
		i=i+1
		rsObj.MoveNext
	Loop		
	rsObj.Close	:	set rsObj=Nothing
	'die PageDesc
	'die "insert into Aspcms_News(Title,SortID,AddTime,ImagePath,Content,NewsTag,NewsStatus,PageDesc"&specStr&") values('"&Title&"',"&SortID&",'"&now()&"','"&ImagePath&"','"&Content&"','"&NewsTag&"',"&NewsStatus&",'"&PageDesc&"' "&valueStr&")"
	Conn.Exec"insert into Aspcms_News(Title,SortID,AddTime,ImagePath,Content,NewsTag,NewsStatus,PageDesc"&specStr&",Exclusive,GradeID) values('"&Title&"',"&SortID&",'"&now()&"','"&ImagePath&"','"&Content&"','"&NewsTag&"',"&NewsStatus&",'"&PageDesc&"' "&valueStr&",'"&Exclusive&"',"&GradeID&")","exe"	
	MakeNewContent "add",SortID
	alertMsgAndGo "���ӳɹ�","AspCms_ProductAdd.asp?sort="&SortID
End Sub

Sub EditProduct
	NewsID=getForm("NewsID","post")
	Title=getForm("Title","post")
	spec=split(getForm("spec","post"),",")
	ImagePath=getForm("ImagePath","post")
	Content=encodeHtml(getForm("Content","post"))
	NewsStatus=getCheck(getForm("NewsStatus","post"))
	NewsTag=getForm("NewsTag","post")	
	PageDesc=left(getForm("PageDesc","post"),255)
	
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
	 
	if isnul(Title) then alertMsgAndGo "��Ʒ���Ʋ���Ϊ��","-1"
	if isnul(ImagePath) then alertMsgAndGo "���ϴ�ͼƬ","-1"
	if isnul(NewsStatus) then NewsStatus=0
	 
	Dim specStr	: specStr=""
	Dim valueStr	: valueStr=""
	Dim Str : Str =""
	Dim i	:i=0
	Dim rsObj	:	Set rsObj=Conn.Exec("select SpecField from Aspcms_ProductSpecSet order by SpecOrder,SpecID","r1")
	Do While not rsObj.Eof 		
		Str=Str&","&rsObj(0)&"='"&trim(spec(i))&"'"			
		i=i+1
		rsObj.MoveNext
	Loop		
	rsObj.Close	:	set rsObj=Nothing
	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	
	Conn.Exec"update Aspcms_News set Title='"&Title&"',ImagePath='"&ImagePath&"',Content='"&Content&"',NewsTag='"&NewsTag&"',NewsStatus="&NewsStatus&",PageDesc='"&PageDesc&"' "&Str&" ,Exclusive='"&Exclusive&"',GradeID="&GradeID&" where NewsID="&NewsID,"exe"	
	MakeNewContent "edit",SortID
	alertMsgAndGo "�޸ĳɹ�","AspCms_ProductList.asp?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub productList
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by istop,isrecommend, NewsOrder "&orderAsc&", Newsid desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where 1=1 "
	if not isNul(SortID) then  whereStr=whereStr&" and SortID="&SortID&""
	if not isNul(keyword) then 
		whereStr = whereStr&" and Title like '%"&keyword&"%'"
	end if
	sqlStr = "select NewsID,Title,visits,NewsStatus,SortID,AddTime,IsTop,ImagePath,newsOrder,IsTop,Isrecommend from Aspcms_News "&whereStr&orderStr
	
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>�ؼ��� <font color=red>"""&keyword&"""</font> û�м�¼</td></tr>" 
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>��û�м�¼!</td></tr>"
		end if
	else  
		rsObj.absolutepage = page
		for i = 1 to numPerPage	
			 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
				"<td>"&rsObj(0)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(3),"<a href=""?action=notEnabled&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">����</a>","<a href=""?action=enable&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">δ����</a>")&"</td>"&vbcrlf& _
				"<td>"&rsObj(1)&"<a href=""/"&sitePath&"product/?"&rsObj(4)&"_"&rsObj(0)&".html"" target=""_blank"" title=""�鿴""><img src=""../images/view.png"" border=0 /></a></td>"&vbcrlf& _
				"<td><input type=""hidden"" name=""nid"" value="""&rsObj(0)&""" style=""width:40px;""><input type=""text"" name=""order"" value="""&rsObj(8)&""" style=""width:40px; text-align:center;""/></td>"&vbcrlf& _
				"<td><img src="""&rsObj(7)&""" height=""30px""  /></td>"&vbcrlf& _
				"<td>"&getStr(rsObj(9),"<a href=""?action=notop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=istop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&" "&getStr(rsObj(10),"<a href=""?action=norecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=isrecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&"</td>"&vbcrlf& _
				"<td><a href=""AspCms_ProductEdit.asp?id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">�޸�</a> | <a href=""?action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('ȷ��Ҫɾ����')"">ɾ��</a></td>"&vbcrlf& _
				"<td><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /></td>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"">"&vbcrlf& _
			"<td colspan=""8"">"&vbcrlf& _			
			"<table width=""98%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0""><tr><td>"&vbcrlf& _
			"<div class=""pager"" style=""padding-left:20px;"">"&vbcrlf& _
			"ҳ����"&page&"/"&allPage&"  ÿҳ"&numPerPage &" �ܼ�¼��"&allRecordset&"�� <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��ҳ</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "newslist",SortID)
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">βҳ</a>"&vbcrlf& _
			"</div>"&vbcrlf& _
			"</td>"&vbcrlf& _
			"<td style=""padding-left:20px;"" >"&vbcrlf& _			
			"<input type=""submit"" value=""��������"" onclick=""form.action='?action=uorder&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';""/>"&vbcrlf& _
			"ȫѡ<input type=""checkbox"" name=""chkall"" id=""chkall"" class=""checkbox"" onClick=""checkAll(this.checked,'input','id')"" />��ѡ<input type=""checkbox"" name=""chkothers"" id=""chkothers"" class=""checkbox"" onClick=""checkOthers('input','id')"" />"&vbcrlf& _
		"<input type=""submit"" value=""����ɾ��"" onclick=""if(confirm('ȷ��Ҫɾ����')){form.action='?action=del&pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';}else{return false}"" class=""btn"" /> "&vbcrlf& _
			"</td><tr></table>"&vbcrlf& _
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing	
End Sub

Sub getSpec(newsid)
	Dim rsObj,specFields,rsObj1,i,SpecNames
	specFields=""		
	Set rsObj=Conn.Exec("select SpecName,SpecField from Aspcms_ProductSpecSet order by SpecOrder,SpecID","r1")
	Do While not rsObj.Eof 
		if newsid=0 then
			echo "<div class=""main_form"" onmouseover=""this.style.backgroundColor='#e8f1f6'"" onmouseout=""this.style.backgroundColor=''"">"&vbcrlf& _	
			"<div class=""main_form_txt"">"&rsObj(0)&"��</div>"&vbcrlf& _	
			"<div class=""main_form_input""> <input type=""text"" maxlength=""100"" name=""spec"" class=""input_1"" style=""width:200px"" />"&vbcrlf& _	
			"</div>"&vbcrlf& _	
			"</div>"&vbcrlf
		end if
		specFields=specFields&rsObj(1)&","
		SpecNames=SpecNames&rsObj(0)&","
		rsObj.MoveNext
	Loop
	
	if not rsObj.eof then rsObj.MoveFirst
	if newsid<>0 and not isnul(specFields) then 
		Set rsObj1=Conn.Exec("select "&specFields&"NewsID from Aspcms_News where NewsID="&newsid,"r1")	
		SpecNames=split(SpecNames,",")
		Do While not rsObj1.Eof 
			for i=0 to ubound(SpecNames)-1
				echo "<div class=""main_form"" onmouseover=""this.style.backgroundColor='#e8f1f6'"" onmouseout=""this.style.backgroundColor=''"">"&vbcrlf& _	
				"<div class=""main_form_txt"">"&trim(SpecNames(i))&"��</div>"&vbcrlf& _	
				"<div class=""main_form_input""> <input type=""text"" name=""spec"" class=""input_1"" value="""&trim(rsObj1(i))&""" style=""width:200px"" />"&vbcrlf& _	
				"</div>"&vbcrlf& _	
				"</div>"&vbcrlf
			next
			rsObj1.MoveNext
		Loop
		rsObj1.Close	: Set rsObj1=Nothing
	end if
	rsObj.Close	: Set rsObj=Nothing
End Sub



Sub newsList	
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr,dirstr
	if pic ="1" then 
		dirstr="pic"
	else
		dirstr="news"
	end if
	
	numPerPage=10
	orderStr= " order by istop,isrecommend, NewsOrder "&orderAsc&", Newsid desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where 1=1 "
	if not isNul(SortID) then  whereStr=whereStr&" and SortID="&SortID&""
	if not isNul(keyword) then 
		whereStr = whereStr&" and Title like '%"&keyword&"%'"
	end if
	sqlStr = "select NewsID,Title,visits,NewsStatus,SortID,AddTime,IsTop,ImagePath,newsOrder,IsTop,Isrecommend from Aspcms_News "&whereStr&orderStr
	
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>�ؼ��� <font color=red>"""&keyword&"""</font> û�м�¼</td></tr>" 
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>��û�м�¼!</td></tr>"
		end if
	else  
		rsObj.absolutepage = page
		for i = 1 to numPerPage	

			  
		
			 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
				"<td>"&rsObj(0)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(3),"<a href=""?action=notEnabled&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">����</a>","<a href=""?action=enable&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">δ����</a>")&"</td>"&vbcrlf& _
				"<td>"&rsObj(1)&"<a href=""/"&sitePath&dirstr&"/?"&rsObj(4)&"_"&rsObj(0)&".html"" target=""_blank"" title=""�鿴""><img src=""../images/view.png"" border=0 /></a></td>"&vbcrlf& _				
				"<td><input type=""hidden"" name=""nid"" value="""&rsObj(0)&""" style=""width:40px;""><input type=""text"" name=""order"" value="""&rsObj(8)&""" style=""width:40px; text-align:center;""/></td>"&vbcrlf& _
				"<td>"&rsObj(5)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(9),"<a href=""?action=notop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=istop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&" "&getStr(rsObj(10),"<a href=""?action=norecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=isrecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&"</td>"&vbcrlf& _
				"<td><a href=""AspCms_NewsEdit.asp?pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">�޸�</a> | <a href=""?pic="&pic&"&action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('ȷ��Ҫɾ����')"">ɾ��</a></td>"&vbcrlf& _
				"<td><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /></td>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"">"&vbcrlf& _
			"<td colspan=""8"">"&vbcrlf& _
			"<table width=""98%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0""><tr><td>"&vbcrlf& _
			"<div class=""pager"" style=""padding-left:20px;"">"&vbcrlf& _
			"ҳ����"&page&"/"&allPage&"  ÿҳ"&numPerPage &" �ܼ�¼��"&allRecordset&"�� <a href=""?pic="&pic&"&page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��ҳ</a> <a href=""?pic="&pic&"&page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "newslist",SortID)
		echo pageNumber
		echo"<a href=""?pic="&pic&"&page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> <a href=""?pic="&pic&"&page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">βҳ</a>"&vbcrlf& _
			"</div>"&vbcrlf& _
			"</td>"&vbcrlf& _
			"<td style=""padding-left:20px;"" >"&vbcrlf& _
			"<input type=""submit"" value=""��������"" onclick=""form.action='?action=uorder&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';""/>"&vbcrlf& _
		"ȫѡ<input type=""checkbox"" name=""chkall"" id=""chkall"" class=""checkbox"" onClick=""checkAll(this.checked,'input','id')"" />��ѡ<input type=""checkbox"" name=""chkothers"" id=""chkothers"" class=""checkbox"" onClick=""checkOthers('input','id')"" />"&vbcrlf& _	
		"<input type=""submit"" value=""����ɾ��"" onclick=""if(confirm('ȷ��Ҫɾ����')){form.action='?action=del&pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';}else{return false}"" class=""btn"" /> "&vbcrlf& _
			"</td><tr></table>"&vbcrlf& _
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing	
End Sub

Sub AddNews
	SortID=getForm("SortID","post")
	Title=getForm("Title","post")
	NewsSource=getForm("NewsSource","post")	
	NewsTag=getForm("NewsTag","post")
	Content=encodeHtml(getForm("Content","post"))
	NewsStatus=getCheck(getForm("NewsStatus","post"))	
	NewsOrder=0	
	Visits=getForm("Visits","post")
	AddTime=getForm("AddTime","post")	
	ImagePath=getForm("ImagePath","post")
	PageDesc=left(getForm("PageDesc","post"),255)
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
		
	
	
	if isnul(Title) then alertMsgAndGo"����д����","-1"
	if isurl(Content) then alertMsgAndGo"����д����","-1"	
	if not isnum(Visits) then Visits=0
	if not isdate(AddTime) then alertMsgAndGo"������ȷ��д��������","-1"
	Dim sql,msg 	
	sql ="insert into Aspcms_News(SortID,Title,NewsSource,NewsTag,Content,NewsStatus,NewsOrder,AddTime,Visits,ImagePath,PageDesc,GradeID,Exclusive) values('"&SortID&"','"&Title&"','"&NewsSource&"','"&NewsTag&"','"&Content&"','"&NewsStatus&"',"&NewsOrder&",'"&AddTime&"',"&Visits&",'"&ImagePath&"','"&PageDesc&"',"&GradeID&",'"&Exclusive&"')"
		'die sql
	msg="����ɹ�"
	Conn.Exec sql,"exe"	
	MakeNewContent "add",SortID
	alertMsgAndGo msg,"AspCms_NewsAdd.asp?sort="&sortID&"&pic="&getForm("pic","get")

End Sub 

Sub EditNews
	NewsID=getForm("NewsID","post")
	SortID=getForm("SortID","post")
	Title=getForm("Title","post")
	NewsSource=getForm("NewsSource","post")	
	NewsTag=getForm("NewsTag","post")
	Content=encodeHtml(getForm("Content","post"))	
	NewsStatus=getCheck(getForm("NewsStatus","post"))	
	NewsOrder=0	
	Visits=getForm("Visits","post")
	AddTime=getForm("AddTime","post")	
	ImagePath=getForm("ImagePath","post")
	PageDesc=left(getForm("PageDesc","post"),255)
	Exclusive=getForm("Exclusive","post")
	GradeID=getForm("GradeID","post")
	
	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")

	
	if isnul(Title) then alertMsgAndGo"����д����","-1"
	if isurl(Content) then alertMsgAndGo"����д����","-1"	
	if not isnum(Visits) then Visits=0
	if not isdate(AddTime) then alertMsgAndGo"������ȷ��д��������","-1"
	Dim sql,msg 	
	sql = "update Aspcms_News set Title='"&Title&"',AddTime='"&AddTime&"',Visits="&Visits&",NewsSource='"&NewsSource&"',NewsTag='"&NewsTag&"',Content='"&Content&"',NewsStatus='"&NewsStatus&"',NewsOrder='"&NewsOrder&"',ImagePath='"&ImagePath&"',PageDesc='"&PageDesc&"',GradeID="&GradeID&",Exclusive='"&Exclusive&"' where NewsID="&NewsID
	msg="����ɹ�"
	
	Conn.Exec sql,"exe"	

	MakeNewContent "edit",SortID
	alertMsgAndGo msg,"AspCms_NewsList.asp?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub DownList	
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by istop,isrecommend, NewsOrder "&orderAsc&", Newsid desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where 1=1 "
	if not isNul(SortID) then  whereStr=whereStr&" and SortID="&SortID&""
	if not isNul(keyword) then 
		whereStr = whereStr&" and Title like '%"&keyword&"%'"
	end if
	sqlStr = "select NewsID,Title,visits,NewsStatus,SortID,AddTime,IsTop,ImagePath,newsOrder,IsTop,Isrecommend from Aspcms_News "&whereStr&orderStr
	
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>�ؼ��� <font color=red>"""&keyword&"""</font> û�м�¼</td></tr>"
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>��û�м�¼!</td></tr>"
		end if
	else  
		rsObj.absolutepage = page
		for i = 1 to numPerPage	
			 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
				"<td>"&rsObj(0)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(3),"<a href=""?action=notEnabled&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">����</a>","<a href=""?action=enable&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">δ����</a>")&"</td>"&vbcrlf& _
				"<td>"&rsObj(1)&"<a href=""/"&sitePath&"down/?"&rsObj(4)&"_"&rsObj(0)&".html"" target=""_blank"" title=""�鿴""><img src=""../images/view.png"" border=0 /></a></td>"&vbcrlf& _				
				"<td><input type=""hidden"" name=""nid"" value="""&rsObj(0)&""" style=""width:40px;""><input type=""text"" name=""order"" value="""&rsObj(8)&""" style=""width:40px; text-align:center;""/></td>"&vbcrlf& _
				"<td>"&rsObj(5)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(9),"<a href=""?action=notop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=istop&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&" "&getStr(rsObj(10),"<a href=""?action=norecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">��</a>","<a href=""?action=isrecommend&pic="&pic&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C2"">��</a>")&"</td>"&vbcrlf& _
				"<td><a href=""AspCms_DownEdit.asp?pic="&getForm("pic","get")&"&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">�޸�</a> | <a href=""?action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('ȷ��Ҫɾ����')"">ɾ��</a></td>"&vbcrlf& _
				"<td><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /></td>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"">"&vbcrlf& _
			"<td colspan=""8"">"&vbcrlf& _
			"<table width=""98%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0""><tr><td>"&vbcrlf& _
			"<div class=""pager"" style=""padding-left:20px;"">"&vbcrlf& _
			"ҳ����"&page&"/"&allPage&"  ÿҳ"&numPerPage &" �ܼ�¼��"&allRecordset&"�� <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��ҳ</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "newslist",SortID)
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">βҳ</a>"&vbcrlf& _
			"</div>"&vbcrlf& _
			"</td>"&vbcrlf& _
			"<td style=""padding-left:20px;"" >"&vbcrlf& _	
			"<input type=""submit"" value=""��������"" onclick=""form.action='?action=uorder&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';""/>"&vbcrlf& _
		"ȫѡ<input type=""checkbox"" name=""chkall"" id=""chkall"" class=""checkbox"" onClick=""checkAll(this.checked,'input','id')"" />��ѡ<input type=""checkbox"" name=""chkothers"" id=""chkothers"" class=""checkbox"" onClick=""checkOthers('input','id')"" />"&vbcrlf& _
		"<input type=""submit"" value=""����ɾ��"" onclick=""if(confirm('ȷ��Ҫɾ����')){form.action='?action=del&pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';}else{return false}"" class=""btn"" /> "&vbcrlf& _
			"</td><tr></table>"&vbcrlf& _
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing	
End Sub


Sub AddSpec 	
	Dim SpecName	: SpecName=getForm("SpecName","post")
	Dim SpecOrder	: SpecOrder=getForm("SpecOrder","post")
	Dim SpecField	: SpecField=getForm("SpecField","post")	
	
	if isnul(SpecName) then alertMsgAndGo "�������Ʋ���Ϊ�գ����޸�","-1"
	if isnul(SpecField) then alertMsgAndGo "�ֶ����Ʋ���Ϊ�գ����޸�","-1"
	Dim rsObj	:	Set rsObj=conn.Exec("select count(*) from Aspcms_ProductSpecSet where SpecField='"&SpecField&"'","r1")
	if rsObj(0) >0 then alertMsgAndGo "�ֶ������Ѵ��ڣ����޸�","-1"
	rsObj.close	:	Set rsObj = nothing
	conn.Exec "ALTER TABLE Aspcms_News ADD column "&SpecField&" Memo" ,"exe"	
	if Err then alertMsgAndGo "�����ֶ�ʧ��,����ϵ����Ա","-1"
	conn.Exec "insert into Aspcms_ProductSpecSet(SpecName,SpecField,SpecOrder) values('"&SpecName&"','"&SpecField&"',"&SpecOrder&")","exe"		
	alertMsgAndGo "���ӳɹ�","AspCms_ProductSpec.asp"
End Sub	

Sub SpecList
	Dim rsObj	:	Set rsObj=conn.Exec("select SpecID,SpecName,SpecField,SpecOrder from Aspcms_ProductSpecSet Order by SpecOrder Asc,SpecID","r1")
	If rsObj.Eof Then 
		echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td colspan=""5"">û������</td>"&vbcrlf& _
		  "</tr>"&vbcrlf
	Else
		Do while not rsObj.Eof 
		 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td>"&rsObj(0)&"</td>"&vbcrlf& _
			"<td>"&rsObj(1)&"</td>"&vbcrlf& _
			"<td>"&rsObj(2)&"</td>"&vbcrlf& _
			"<td>"&rsObj(3)&"</td>"&vbcrlf& _
			"<td><a href=""?action=delspec&id="&rsObj(0)&"&SpecField="&rsObj(2)&""" class=""txt_C1"" onClick=""return confirm('ȷ��Ҫɾ����')"">ɾ��</a></td>"&vbcrlf& _
		  "</tr>"&vbcrlf
		  rsObj.MoveNext
		Loop
	End If
	rsObj.close	:	Set rsObj = nothing
End Sub

Sub DelSpec 
	Dim ID 	:	ID = getForm("id","get")
	Dim SpecField	: SpecField=getForm("SpecField","get")	
	conn.Exec "ALTER TABLE Aspcms_News drop column "&SpecField,"exe"
	if Err then alertMsgAndGo "ɾ���ֶ�ʧ��,����ϵ����Ա","-1"
	conn.Exec "Delete * from Aspcms_ProductSpecSet where SpecField='"&SpecField&"'","exe"
	alertMsgAndGo "ɾ���ɹ�","AspCms_ProductSpec.asp"	
End Sub 

Sub NotEnabled	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_News set NewsStatus=0 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub Enable
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_News set NewsStatus=1 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub


Sub ToTop	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Dim id				:	id=getForm("ID","get")	
	Conn.Exec"update Aspcms_News set IsTop=1 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub NoTop
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_News set IsTop=0 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub ToRecommend	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Dim id				:	id=getForm("ID","get")	
	Conn.Exec"update Aspcms_News set Isrecommend=1 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub NoRecommend
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_News set Isrecommend=0 Where NewsID="&id,"exe"
	response.Redirect getPageName()&"?pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub
%>