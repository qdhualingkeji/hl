<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_SettingFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ϵͳ�������-��վ�������</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">ϵͳ�������-��վ�������</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editad " method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>�������</strong></div>
	  	  </div>
          <div class="maintable">
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ʾ״̬��</div>
		<div class="main_form_input">             
            <input type="radio"  value="1" name="adStatus" <% if adStatus=1 then echo "checked" end if%>/>��ʾ
            <input type="radio" value="0" name="adStatus" <% if adStatus=0 then echo "checked" end if%>/>����
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">ͼƬ��ַ��</div>
		<div class="main_form_input"> 
        	<input type="text" name="adImagePath" id="adImagePath" style="width:300px" value="<%=adImagePath%>"/>
		</div>
		</div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">�ϴ�ͼƬ��</div>
		<div class="main_form_input"> 
        	<iframe src="../fckeditor/upload.asp?action=news&amp;Tobj=adImagePath" scrolling="No" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="left"></iframe>
		</div>
		</div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���ӵ�ַ��</div>
		<div class="main_form_input"> 
        	<input name="adLink" type="text"  style="width:300px" value="<%=adLink%>" /> ����������"#"
		</div>
		</div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">ͼƬ��С��</div>
		<div class="main_form_input"> 
        	����<input name="adImgWidth" type="text" style="width:40px" value="<%=adImgWidth%>"/> 
            �ߣ�<input name="adImgHeight" type="text"  style="width:40px" value="<%=adImgHeight%>"/>
		</div>
		</div>

		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���ñ�ǩ��</div>
		<div class="main_form_input">{aspcms:floatad}
		</div>
		</div>
        
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt"></div>
		<div class="main_form_input"> 
        	<input type="submit" value=" ���� " />
		</div>
		</div>
		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>�������˵�� </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">������棺</div>
		<div class="main_form_input"> 
        	ָƯ����ҳ���ϲ����ƶ��Ĺ�棬���Сһ��Ϊ80*80
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">������棺</div>
		<div class="main_form_input"> 
        	ָ�̶���ʾ��ҳ������Ĺ��
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">����ʽ���棺</div>
		<div class="main_form_input"> 
        	ָ����ָ����Сҳ���������ʽ����
		</div>
		</div>
	</form>
</div>
</body>
</html>