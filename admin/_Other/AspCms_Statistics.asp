<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_OtherFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������-��վ����ͳ��</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">��������-��վ����ͳ��</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=clear" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>����ͳ��</strong></div>
	  	  </div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���շ�������</div>
		<div class="main_form_input"> 
        	<input type="text" style="width:200px;"  value="<%=getTodayVisits%>"/>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���շ�������</div>
		<div class="main_form_input"> 
			<input type="text" style="width:200px;"  value="<%=getYesterdayVisits%>"/>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���·�������</div>
		<div class="main_form_input"> 
        	<input type="text" style="width:200px" value="<%=getMonthVisits%>"/>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">			<div class="main_form_txt">�ܷ�������</div>
		<div class="main_form_input"> 
        	<input type="text" style="width:200px"  value="<%=getAllVisits%>"/>
		</div>
		</div>
		
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">			<div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value="ȫ������"  onClick="return confirm('ȷ��Ҫ������')" class="btn"/>
		</div>
        </div>
	</form>
</div>
</body>
</html>