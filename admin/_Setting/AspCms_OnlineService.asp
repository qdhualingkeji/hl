<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_SettingFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ϵͳ�������-���߿ͷ�����</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">ϵͳ�������-���߿ͷ�����</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editservice" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>���߿ͷ��б�</strong></div>
	  	  </div>
          <div class="maintable">
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ʾ״̬:</div>
		<div class="main_form_input"> 
            <input type="radio"  value="1" name="serviceStatus" <% if serviceStatus=1 then echo "checked" end if%>/>��ʾ
            <input type="radio" value="0" name="serviceStatus" <% if serviceStatus=0 then echo "checked" end if%>/>����
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ʽ:</div>
		<div class="main_form_input"> 
            <input type="radio"  value="1" name="serviceStyle" <% if serviceStyle=1 then echo "checked" end if%>/>��ʽһ
            <input type="radio" value="2" name="serviceStyle" <% if serviceStyle=2 then echo "checked" end if%>/>��ʽ��		</div>
		</div>
        <div class="main_form" style=" display:none" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ʾλ��:</div>
		<div class="main_form_input"> 
            <input type="radio" value="left" name="serviceLocation" <% if serviceLocation="left" then echo "checked" end if%>/>���
            <input type="radio" value="right" name="serviceLocation" <% if serviceLocation="right" then echo "checked" end if%>/>�ұ�
		</div>
		</div>
        
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">QQ��</div>
		<div class="main_form_input"> 
        	<input type="text" name="serviceQQ"  style="width:400px" value="<%=serviceQQ%>"/> ������ÿո����
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">������</div>
		<div class="main_form_input"> 
        	<input type="text" name="serviceWangWang" style="width:400px" value="<%=serviceWangWang%>"/>
       	  ������ÿո����		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���䣺</div>
		<div class="main_form_input"> 
        	<input type="text" name="serviceEmail"  style="width:400px" value="<%=serviceEmail%>"/>
       	  ������ÿո����		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">�绰��</div>
		<div class="main_form_input"> 
        	<input type="text" name="servicePhone" style="width:400px" value="<%=servicePhone%>"/>
       	  ������ÿո����		</div>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ϵ��ʽ���ӣ�</div>
		<div class="main_form_input"> 
        	<input type="text" name="serviceContact"  style="width:400px" value="<%=serviceContact%>"/>
       	 </div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���ñ�ǩ��</div>
		<div class="main_form_input">{aspcms:onlineservice}
		</div>
		</div>
        
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>�������ͷ�ϵͳ </strong></div>
	  	  </div>
             <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ʾ״̬:</div>
		<div class="main_form_input"> 
            <input type="radio" value="1" name="servicekfStatus" <% if servicekfStatus=1 then echo "checked" end if%>/>��ʾ
            <input type="radio" value="0" name="servicekfStatus" <% if servicekfStatus=0 then echo "checked" end if%>/>����
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">53�ͷ�ϵͳ��</div>
		<div class="main_form_input"> 
			<textarea name="servicekf" cols="40" rows="6" style="width:500px"><%=decode(servicekf)%></textarea>
		</div>
		</div>
        
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���ñ�ǩ��</div>
		<div class="main_form_input">{aspcms:53kf}
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ע��</div>
		<div class="main_form_input"> 
        	 �˴��ɷ��õ������ͷ�ϵͳ!
		</div>
		</div>

        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" �� �� " class="btn" />
		</div>
		</div>
	</form>
</div>
</body>
</html>