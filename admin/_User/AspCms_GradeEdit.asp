<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_UserFun.asp" -->
<% 
getGrade
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>会员等级管理</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">会员等级管理</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editgrade" method="post" name="form">         
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>会员等级修改 </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		<div class="main_form_txt">等级名称：</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="GradeName" value="<%=GradeName%>"/>
        	<input type="hidden"  name="GradeID" value="<%=GradeID%>"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">权限：</div>
		<div class="main_form_input"> <input type="text" name="GradeMark" value="<%=GradeMark%>" style="width:100px" /> 权限值越高，权限最大
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">颜色：</div>
		<div class="main_form_input">			
        	<input type="input" name="GradeColor" style="width:100px" value="<%=GradeColor%>" />
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">状态：</div>
		<div class="main_form_input">  
			<input type="checkbox"   <% if GradeStatus then echo"checked=""checked"""%> value="1" name="GradeStatus"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">排序：</div>
		<div class="main_form_input"> 
			<input type="input" name="GradeOrder"  value="<%=GradeOrder%>" style="width:100px"/>
		</div>
		</div>
        
        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">等级图片：</div>
		<div class="main_form_input"> 
        <input type="text" name="GradeImage" id="GradeImage" style="width:300px"   value="<%=GradeImage%>"/>
		</div>
        </div>      

        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">上传图片：</div>
		<div class="main_form_input"> 
        <iframe src="../fckeditor/upload.asp?action=news&Tobj=GradeImage" scrolling="no" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="center"></iframe>
		</div>
        </div>  
          <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">备注：</div>
		<div class="main_form_input">        
        <textarea name="GradeDesc" cols="40" rows="6" style="width:500px"><%=GradeDesc%></textarea>
		</div>
        </div>  
        
        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 保存 " class="btn"/>
		  <input type="button"  value=" 返回 " class="btn" onclick="history.go(-1)"/>
		</div>
		</div>
		</div>
	</form>
</div>
</body>
</html>