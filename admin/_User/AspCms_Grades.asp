<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_UserFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>会员等级设置</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">会员等级设置</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=addgrade" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>会员等级列表</strong></div>
	  	  </div>
          <div class="maintable">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="7%">ID</td>
                <td width="24%">等级名称</td>
                <td width="16%">权限</td>
                <td width="20%">颜色</td>
                <td width="10%">排序</td>
                <td width="9%">状态</td>
                <td width="14%">操作</td>
              </tr>
              <%GradesList%>
            </table>
            
		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>添加新等级 </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		<div class="main_form_txt">等级名称：</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="GradeName"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">权限：</div>
		<div class="main_form_input"> <input type="text" name="GradeMark" value="0" style="width:100px" />权限值越高，权限最大
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">颜色：</div>
		<div class="main_form_input">			
        	<input type="input" name="GradeColor" style="width:100px"/>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">状态：</div>
		<div class="main_form_input">  
			<input type="checkbox"  checked="checked" value="1" name="GradeStatus"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">排序：</div>
		<div class="main_form_input"> 
			<input type="input" name="GradeOrder" value="99" style="width:100px"/>
		</div>
		</div>
        
        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">等级图片：</div>
		<div class="main_form_input"> 
        <input type="text" name="GradeImage" style="width:300px"  id="GradeImage" />
		</div>
        </div>      

        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">上传图片：</div>
		<div class="main_form_input"> 
        <iframe src="../fckeditor/upload.asp?action=news&Tobj=GradeImage" scrolling="no" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="center"></iframe>
		</div>
        </div>  
        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">备注：</div>
		<div class="main_form_input">        
        <textarea name="GradeDesc" cols="40" rows="6" style="width:500px"></textarea>
		</div>
        </div>  
		
        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 添 加 " class="btn" onclick="form.action='?action=addgrade';"/>
		</div>
		</div>
       
		</div>
	</form>
</div>
</body>
</html>