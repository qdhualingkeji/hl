<%
CheckAdmin()
'定义类别ID，搜索关键词，页数，排序
Dim SortID,keyword,page,order,pic,ID

SortID =getForm("sort","get")	
keyword=getForm("keyword","post")
if isnul(keyword) then keyword=getForm("keyword","get")
page=getForm("page","get")
order=getForm("order","get")
pic=getForm("pic","get")
ID=getForm("id","get")


select case action 
	case "edit" : editUser	
	case "del" : delUser	
	
	case "enable" :Enable
	case "notenabled" :NotEnabled	
	
	case "gradenable" :gradeEnable
	case "gradnotenabled" :gradeNotEnabled	
	
	case "addgrade" addGrade
	case "editgrade" editGrade
	case "delgrade" delGrade	
end select
	
Dim GradeID,GradeName,GradeMark,GradeImage,GradeColor,GradeAvatar,GradeOrder,GradeStatus,GradeDesc,Phone,TrueName

Sub addGrade
	GradeName=getForm("GradeName","post")
	GradeMark=getForm("GradeMark","post")
	GradeImage=getForm("GradeImage","post")
	GradeColor=getForm("GradeColor","post")
	GradeAvatar=getForm("GradeAvatar","post")
	GradeOrder=getForm("GradeOrder","post")
	GradeStatus=getCheck(getForm("GradeStatus","post"))
	GradeDesc=getForm("GradeDesc","post")
	
	if isnul(GradeName) then alertMsgAndGo "分组名称不能为空","-1"
	
	Conn.Exec"insert into Aspcms_UserGrades(GradeName,GradeMark,GradeImage,GradeColor,GradeAvatar,GradeOrder,GradeStatus,GradeDesc) values('"&GradeName&"','"&GradeMark&"','"&GradeImage&"','"&GradeColor&"','"&GradeAvatar&"',"&GradeOrder&","&GradeStatus&",'"&GradeDesc&"')","exe"
	alertMsgAndGo "添加成功","AspCms_Grades.asp"
End Sub

Sub editGrade
	GradeID=getForm("GradeID","post")
	GradeName=getForm("GradeName","post")
	GradeMark=getForm("GradeMark","post")
	GradeImage=getForm("GradeImage","post")
	GradeColor=getForm("GradeColor","post")
	GradeAvatar=getForm("GradeAvatar","post")
	GradeOrder=getForm("GradeOrder","post")
	GradeStatus=getCheck(getForm("GradeStatus","post"))
	GradeDesc=getForm("GradeDesc","post")
	Conn.Exec"update Aspcms_UserGrades set GradeName='"&GradeName&"',GradeMark='"&GradeMark&"',GradeImage='"&GradeImage&"',GradeColor='"&GradeColor&"',GradeAvatar='"&GradeAvatar&"',GradeOrder="&GradeOrder&",GradeStatus="&GradeStatus&",GradeDesc='"&GradeDesc&"' where GradeID="&GradeID,"exe"
	alertMsgAndGo "修改成功","AspCms_Grades.asp"
End Sub

Sub delGrade	
	Dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要删除的内容","-1"

	if id<3 then alertMsgAndGo "系统默认分组不能删除","AspCms_Grades.asp"
	
	Conn.Exec "delete * from Aspcms_UserGrades where GradeID in("&id&")","exe"
	alertMsgAndGo "删除成功","AspCms_Grades.asp"

End Sub

Sub getGrade	
	if not isnul(ID) then		
		Dim rs : Set rs = Conn.Exec("select * from Aspcms_UserGrades where GradeID="&ID,"r1")
		if not rs.eof then	
			GradeID=rs("GradeID")
			GradeName=rs("GradeName")
			GradeMark=rs("GradeMark")
			GradeImage=rs("GradeImage")
			GradeColor=rs("GradeColor")
			GradeAvatar=rs("GradeAvatar")
			GradeOrder=rs("GradeOrder")
			GradeStatus=rs("GradeStatus")
			GradeDesc=rs("GradeDesc")
		end if
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if
End Sub

Sub GradesList
	Dim rsObj	:	Set rsObj=conn.Exec("select GradeID,GradeName,GradeMark,GradeColor,GradeOrder,GradeStatus,GradeAvatar,GradeImage from Aspcms_UserGrades Order by GradeOrder, GradeID","r1")
	If rsObj.Eof Then 
		echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td colspan=""7"">没有数据</td>"&vbcrlf& _
		  "</tr>"&vbcrlf
	Else
		Do while not rsObj.Eof 
		 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td>"&rsObj(0)&"</td>"&vbcrlf& _
			"<td>"&rsObj(1)&"</td>"&vbcrlf& _
			"<td>"&rsObj(2)&"</td>"&vbcrlf& _
			"<td>"&rsObj(3)&"</td>"&vbcrlf& _
			"<td>"&rsObj(4)&"</td>"&vbcrlf
		if rsObj(0)<3 then
		echo "<td>"&getStr(rsObj(5),"<a href=""?action=gradnotenabled&id="&rsObj(0)&""" class=""txt_C1"">启用</a>","<a href=""?action=gradenable&id="&rsObj(0)&""" class=""txt_C4"">禁用</a>")&"</td>"&vbcrlf& _
			"<td><a href=""AspCms_GradeEdit.asp?id="&rsObj(0)&""" class=""txt_C1"">修改</a> | 删除</td>"&vbcrlf& _
		  "</tr>"&vbcrlf
		 else
		echo "<td>"&getStr(rsObj(5),"<a href=""?action=gradnotenabled&id="&rsObj(0)&""" class=""txt_C1"">启用</a>","<a href=""?action=gradenable&id="&rsObj(0)&""" class=""txt_C4"">禁用</a>")&"</td>"&vbcrlf& _
			"<td><a href=""AspCms_GradeEdit.asp?id="&rsObj(0)&""" class=""txt_C1"">修改</a> | <a href=""?action=delgrade&id="&rsObj(0)&""" class=""txt_C1"" onClick=""return confirm('确定要删除吗')"">删除</a></td>"&vbcrlf& _
		  "</tr>"&vbcrlf	 
		 
		 end if
		  rsObj.MoveNext
		Loop
	End If
	rsObj.close	:	Set rsObj = nothing
End Sub

Dim UserID,UserName,Password,Email,Mobile,Address,PostCode,Gender,QQ,UserStatus,RegisterTime,LastLoginIP,LastLoginTime,Birthday,Exp1,Exp2,Exp3

Sub delUser	
	Dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要删除的内容","-1"
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Conn.Exec "delete * from Aspcms_Users where UserID in("&id&")","exe"
	alertMsgAndGo "删除成功","?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub getContent
	if not isnul(ID) then		
		Dim rs : Set rs = Conn.Exec("select * from Aspcms_Users where UserID="&ID,"r1")
		if not rs.eof then	
			UserID=rs("UserID")
			GradeID=rs("GradeID")
			UserName=rs("UserName")
			Password=rs("Password")
			Email=rs("Email")
			Mobile=rs("Mobile")
			Address=rs("Address")
			PostCode=rs("PostCode")
			Gender=rs("Gender")
			QQ=rs("QQ")
			UserStatus=rs("UserStatus")
			RegisterTime=rs("RegisterTime")
			LastLoginIP=rs("LastLoginIP")
			LastLoginTime=rs("LastLoginTime")
			Birthday=rs("Birthday")
			Exp1=rs("Exp1")
			Exp2=rs("Exp2")
			Exp3=rs("Exp3")		
			Phone=rs("Phone")			
			TrueName=rs("TrueName")		
		end if
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if
End Sub

Sub editUser

	UserID=getForm("UserID","post")
	Password=filterPara(getForm("userPass","post"))
	Email=filterPara(getForm("Email","post"))
	Mobile=filterPara(getForm("Mobile","post"))
	Address=filterPara(getForm("Address","post"))
	PostCode=filterPara(getForm("PostCode","post"))
	Gender=filterPara(getForm("Gender","post"))
	QQ=filterPara(getForm("QQ","post"))
	UserStatus=getCheck(getForm("UserStatus","post"))
	GradeID=getForm("GradeID","post")
	TrueName=getForm("TrueName","post")
	Phone=getForm("Phone","post")
	
	dim passStr
	if not isnul(Password) then passStr="[Password]='"&md5(PassWord,16)&"',"	
		
	Conn.Exec"update Aspcms_Users set "&passStr&" Email='"&Email&"',QQ='"&QQ&"',Mobile='"&Mobile&"',Address='"&Address&"',PostCode='"&PostCode&"',Gender="&Gender&",UserStatus="&UserStatus&",GradeID="&GradeID&",Phone='"&Phone&"',TrueName='"&TrueName&"' where UserID="&UserID,"exe"	
	alertMsgAndGo "修改成功","AspCms_UserList.asp?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub UserList	
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by UserID desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where 1=1 "
	if not isNul(SortID) then  whereStr=whereStr
	if not isNul(keyword) then 
		whereStr = whereStr&" and UserName like '%"&keyword&"%'"
	end if
	sqlStr = "select UserID,UserName,Gender,Email,QQ,LastLoginTime,UserStatus,Aspcms_Users.GradeID,GradeName,Mobile,Address,PostCode,RegisterTime,LastLoginIP,Birthday,Exp1,Exp2,Exp3 from Aspcms_Users,Aspcms_UserGrades "&whereStr&" and Aspcms_Users.GradeID=Aspcms_UserGrades.GradeID "&orderStr
	
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='9'>关键字 <font color=red>"""&keyword&"""</font> 没有记录</td></tr>" 
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='9'>还没有记录!</td></tr>"
		end if
	else  
		rsObj.absolutepage = page
		for i = 1 to numPerPage	
			 echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
				"<td>"&rsObj(0)&"</td>"&vbcrlf& _
				"<td>"&rsObj(1)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(2),"男","女")&"</td>"&vbcrlf& _
				"<td>"&rsObj(3)&"/"&rsObj(4)&"</td>"&vbcrlf& _
				"<td>"&rsObj(8)&"</td>"&vbcrlf& _
				"<td>"&rsObj(5)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(6),"<a href=""?action=notenabled&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">启用</a>","<a href=""?action=enable&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4"">禁用</a>")&"</td>"&vbcrlf& _
				"<td><a href=""AspCms_UserEdit.asp?id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"">查看</a> | <a href=""?action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('确定要删除吗')"">删除</a></td>"&vbcrlf& _
				"<td><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /></td>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"">"&vbcrlf& _
			"<td colspan=""5"">"&vbcrlf& _
			"<div class=""pager"" style=""padding-left:20px;"">"&vbcrlf& _
			"页数："&page&"/"&allPage&"  每页"&numPerPage &" 总记录数"&allRecordset&"条 <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">首页</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">上一页</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "newslist","")
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">下一页</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">尾页</a>"&vbcrlf& _
			"</div>"&vbcrlf& _
			"</td>"&vbcrlf& _
			"<td colspan=""4"" style=""padding-left:20px;"" >"&vbcrlf& _
		"全选<input type=""checkbox"" name=""chkall"" id=""chkall"" class=""checkbox"" onClick=""checkAll(this.checked,'input','id')"" />反选<input type=""checkbox"" name=""chkothers"" id=""chkothers"" class=""checkbox"" onClick=""checkOthers('input','id')"" />"&vbcrlf& _
		"<input type=""submit"" value=""批量删除"" onclick=""if(confirm('确定要删除吗')){form.action='?action=del&pic="&pic&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&"';}else{return false}"" class=""btn"" /> "&vbcrlf& _
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing	
End Sub

Sub NotEnabled	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_Users set UserStatus=0 Where UserID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub Enable
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_Users set UserStatus=1 Where UserID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub gradeNotEnabled	
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_UserGrades set GradeStatus=0 Where GradeID="&id,"exe"
	response.Redirect getPageName()
End Sub

Sub gradeEnable
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update Aspcms_UserGrades set GradeStatus=1 Where GradeID="&id,"exe"
	response.Redirect getPageName()
End Sub
%>