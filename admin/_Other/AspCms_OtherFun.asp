<%
'CheckAdmin()

Select Case action
	Case "editslide" 	 : Call EditSlide()
	Case "clear" 	 : Call StatisticsClear()
End Select 

Sub EditSlide
	Dim Str
	Str="'幻灯片设置"&vbcrlf& _
	"Const slideImgs="""&getForm("slideImgs","post")&"""	'图片地址"&vbcrlf& _
	"Const slideLinks="""&getForm("slideLinks","post")&"""	'链接地址"&vbcrlf& _
	"Const slideTexts="""&getForm("slideTexts","post")&"""	'文字说明"&vbcrlf& _
	"Const slideWidth="""&getForm("slideWidth","post")&"""	'宽"&vbcrlf& _
	"Const slideHeight="""&getForm("slideHeight","post")&"""	'高"&vbcrlf&_
	"Const slideTextStatus="&getForm("slideTextStatus","post")&"	'文字说明开关"&vbcrlf
	

	createTextFile "<"&"%"&vbcrlf&Str&vbcrlf&"%"&">","../../config/AspCms_SlideConfig.asp",""
	alertMsgAndGo "幻灯片设置成功","AspCms_Slide.asp" 
End Sub

Sub StatisticsClear
	conn.Exec"delete * from Aspcms_Visits","exe"	
	response.Redirect("AspCms_Statistics.asp")
End Sub




%>