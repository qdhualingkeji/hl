<%
'CheckAdmin()

Select Case action
	Case "editslide" 	 : Call EditSlide()
	Case "clear" 	 : Call StatisticsClear()
End Select 

Sub EditSlide
	Dim Str
	Str="'�õ�Ƭ����"&vbcrlf& _
	"Const slideImgs="""&getForm("slideImgs","post")&"""	'ͼƬ��ַ"&vbcrlf& _
	"Const slideLinks="""&getForm("slideLinks","post")&"""	'���ӵ�ַ"&vbcrlf& _
	"Const slideTexts="""&getForm("slideTexts","post")&"""	'����˵��"&vbcrlf& _
	"Const slideWidth="""&getForm("slideWidth","post")&"""	'��"&vbcrlf& _
	"Const slideHeight="""&getForm("slideHeight","post")&"""	'��"&vbcrlf&_
	"Const slideTextStatus="&getForm("slideTextStatus","post")&"	'����˵������"&vbcrlf
	

	createTextFile "<"&"%"&vbcrlf&Str&vbcrlf&"%"&">","../../config/AspCms_SlideConfig.asp",""
	alertMsgAndGo "�õ�Ƭ���óɹ�","AspCms_Slide.asp" 
End Sub

Sub StatisticsClear
	conn.Exec"delete * from Aspcms_Visits","exe"	
	response.Redirect("AspCms_Statistics.asp")
End Sub




%>