<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_UserFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ա�ȼ�����</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">��Ա�ȼ�����</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=addgrade" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>��Ա�ȼ��б�</strong></div>
	  	  </div>
          <div class="maintable">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="7%">ID</td>
                <td width="24%">�ȼ�����</td>
                <td width="16%">Ȩ��</td>
                <td width="20%">��ɫ</td>
                <td width="10%">����</td>
                <td width="9%">״̬</td>
                <td width="14%">����</td>
              </tr>
              <%GradesList%>
            </table>
            
		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>�����µȼ� </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		<div class="main_form_txt">�ȼ����ƣ�</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="GradeName"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">Ȩ�ޣ�</div>
		<div class="main_form_input"> <input type="text" name="GradeMark" value="0" style="width:100px" />Ȩ��ֵԽ�ߣ�Ȩ�����
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ɫ��</div>
		<div class="main_form_input">			
        	<input type="input" name="GradeColor" style="width:100px"/>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">״̬��</div>
		<div class="main_form_input">  
			<input type="checkbox"  checked="checked" value="1" name="GradeStatus"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">����</div>
		<div class="main_form_input"> 
			<input type="input" name="GradeOrder" value="99" style="width:100px"/>
		</div>
		</div>
        
        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">�ȼ�ͼƬ��</div>
		<div class="main_form_input"> 
        <input type="text" name="GradeImage" style="width:300px"  id="GradeImage" />
		</div>
        </div>      

        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">�ϴ�ͼƬ��</div>
		<div class="main_form_input"> 
        <iframe src="../fckeditor/upload.asp?action=news&Tobj=GradeImage" scrolling="no" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="center"></iframe>
		</div>
        </div>  
        <div id="imglink" class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ע��</div>
		<div class="main_form_input">        
        <textarea name="GradeDesc" cols="40" rows="6" style="width:500px"></textarea>
		</div>
        </div>  
		
        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" �� �� " class="btn" onclick="form.action='?action=addgrade';"/>
		</div>
		</div>
       
		</div>
	</form>
</div>
</body>
</html>