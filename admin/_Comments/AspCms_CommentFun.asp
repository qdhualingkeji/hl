<%
'CheckAdmin()
'�������ID�������ؼ��ʣ�ҳ��������
Dim SortID,keyword,page,order,pic,ID

SortID =getForm("sort","get")	
keyword=getForm("keyword","post")
if isnul(keyword) then keyword=getForm("keyword","get")
page=getForm("page","get")
order=getForm("order","get")
pic=getForm("pic","get")
ID=getForm("id","get")


select case action 
	case "edit" : editComment	
	case "del" : delComment	
	
	case "enable" :Enable
	case "notenabled" :NotEnabled	
end select
Dim CommentID,CommentTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,CommentStatus,AuditStatus


Sub delComment	
	Dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "��ѡ��Ҫɾ��������","-1"
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Conn.Exec "delete * from Aspcms_Comments where CommentID in("&id&")","exe"
	alertMsgAndGo "ɾ���ɹ�","?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub CommentList	
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by CommentStatus desc,Aspcms_Comments.AddTime desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where Aspcms_Comments.NewsID=Aspcms_News.NewsID and Aspcms_NewsSort.SortID=Aspcms_News.SortID"
	if not isNul(SortID) then  whereStr=whereStr
	if not isNul(keyword) then 
		whereStr = whereStr&" and (Commentator like '%"&keyword&"%' or CommentContent like '%"&keyword&"%')"
	end if
	sqlStr = "select CommentID,Commentator,CommentContent,Aspcms_Comments.AddTime,CommentStatus,Aspcms_Comments.NewsID,Aspcms_News.SortID,SortStyle,SortFolder,GradeID from Aspcms_Comments,Aspcms_News,Aspcms_NewsSort "&whereStr&orderStr
	
	
	dim templateobj,templatePath : set templateobj = mainClassobj.createObject("MainClass.template")
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
				"<td>"&rsObj(1)&"</td>"&vbcrlf& _
				"<td align=""left"" style=""padding:2px;line-height:1.5em;"">"&replace(rsObj(2),"<br>","")&"</td>"&vbcrlf& _
				"<td>"&rsObj(3)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(4),"<a href=""?action=notenabled&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">���</a>","<a href=""?action=enable&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">δ���</a>")&"</td>"&vbcrlf& _
				"<td><a target=""_blank"" href="""&templateobj.getShowLink(rsObj(6),rsObj(5),dir(rsObj(7)),rsObj("SortFolder"),rsObj("GradeID"))&""" class=""txt_C1"">�鿴</a> | <a href=""?action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('ȷ��Ҫɾ����')"">ɾ��</a></td>"&vbcrlf& _
				"<td><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /></td>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"">"&vbcrlf& _
			"<td colspan=""4"">"&vbcrlf& _
			"<div class=""pager"" style=""padding-left:20px;"">"&vbcrlf& _
			"ҳ����"&page&"/"&allPage&"  ÿҳ"&numPerPage &" �ܼ�¼��"&allRecordset&"�� <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��ҳ</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "newslist","")
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">��һҳ</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">βҳ</a>"&vbcrlf& _
			"</div>"&vbcrlf& _
			"</td>"&vbcrlf& _
			"<td colspan=""4"" style=""padding-left:20px;"" >"&vbcrlf& _
		"ȫѡ<input type=""checkbox"" name=""chkall"" id=""chkall"" class=""checkbox"" onClick=""checkAll(this.checked,'input','id')"" />��ѡ<input type=""checkbox"" name=""chkothers"" id=""chkothers"" class=""checkbox"" onClick=""checkOthers('input','id')"" />"&vbcrlf& _
		"<input type=""submit"" value=""����ɾ��"" onclick=""if(confirm('ȷ��Ҫɾ����')){form.action='?action=del&pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';}else{return false}"" class=""btn"" /> "&vbcrlf& _
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing		
	set templateobj =nothing : terminateAllObjects
End Sub

Sub NotEnabled	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_Comments set CommentStatus=0 Where CommentID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub Enable
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_Comments set CommentStatus=1 Where CommentID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

%>