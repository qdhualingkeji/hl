<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_StyleFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>风格模板管理-模板管理</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">风格模板管理-选择模板</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
        
         	  <div class="main_form_news_l"><strong>模板文件夹设置</strong></div>
	  	  </div>
          <div class="maintable">
          		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		<div class="main_form_txt">模板文件夹：</div>
		<div class="main_form_input">
		  <input type="text" name="htmlFilePath" class="my_input" style="width:100px" value="<%=htmlFilePath%>"/> 防止模板被盗
		</div>
		</div>
        
        <div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value="修改" onclick="form.action='?action=edithtmlfilepath'"/>
		</div>
		</div>
        
        
	  	  <div class="main_form_news_l"><strong>选择模板</strong></div>
	  	  </div>
          <div class="maintable">
    

            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0" id="stylemain">
                <tr align="center">
                    <td bgcolor="#FFFFFF" width="260px">缩略图</td>
                    <td bgcolor="#FFFFFF" width="">简介</td>    
                </tr>
			<%
			Dim folderArry,folderAttr,i,tempStr
			folderArry=getFolderList("../../Templates")
			if instr(folderArry(0),",")>0 then
				for i=0 to ubound(folderArry)
					folderAttr=split(folderArry(i),",")
					
					'echo folderAttr(0)&","&folderAttr(1)&","&folderAttr(2)&","&folderAttr(3)&","&folderAttr(4)&"<br>"
					
					Dim xmlObj : Set xmlObj=mainClassObj.createObject("MainClass.Xml")
					if isExistFile(folderAttr(4)&"/template.xml") then
						xmlObj.load folderAttr(4)&"/template.xml","xmlfile"
						'echo xmlObj.isExistNode("description")
						'echo xmlObj.getNodeValue("ScreenShot",0)&"<br>"
						'echo xmlObj.getNodeValue("description",0)&"<br>"
						
						if folderAttr(0)=defaultTemplate then
							tempStr="<input type=""button"" value=""正在使用"" />"
						else
							tempStr="<input type=""submit"" value=""使用此模板"" onclick=""form.action='?action=edit&style="&folderAttr(0)&"'""/>"
						end if
						echo"<tr align=""center"">"&vbcrlf& _
							"<td bgcolor=""#FFFFFF"" class=""pic""><img width=""200px"" src="""&folderAttr(4)&"/"&xmlObj.getNodeValue("ScreenShot",0)&"""/></td>"&vbcrlf& _
							"<td bgcolor=""#FFFFFF"" class=""desc"">简介："&xmlObj.getNodeValue("description",0)&"<br />"&tempStr&"</td>               "&vbcrlf& _
						"</tr>"&vbcrlf
					end if
				next
			end if
			%>
            </table>
            
         
		</div>
	</form>
	</div>
</body>
</html>

