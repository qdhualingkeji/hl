<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_MakeHtmlFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ɾ�̬</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script></head>
<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">���ɾ�̬</strong></div>
<div class="main_center_article" id="web_main">
  <form action="?" method="post">
	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>���ɾ�̬</strong></div>
    </div>
    <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
      <div class="main_form_txt"> ȫվ��</div>
      <div class="main_form_input">          
        <input type="submit" value="һ������" onclick="form.action='?action=all'"/>    
      </div>
      </div>
      
     <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
      <div class="main_form_txt"> ��ҳ��</div>
      <div class="main_form_input">             
        <input type="submit" value="������ҳ" onclick="form.action='?action=index'"/> 
      </div>
      </div>
      
    <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
      <div class="main_form_txt"> �б�ҳ��</div>
      <div class="main_form_input">      
        	<%LoadSelect "lsortid","Aspcms_NewsSort","SortName","SortID","", 0,"order by SortOrder","ѡ����Ŀ"%>
            <input type="submit" value="����" onclick="form.action='?action=list'"/>
            <input type="submit" value="��������" onclick="form.action='?action=alllist'"/> 
      </div>
      </div>
      
    <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
      <div class="main_form_txt"> ����ҳ��</div>
      <div class="main_form_input">          
        	<%LoadSelect "csortid","Aspcms_NewsSort","SortName","SortID","", 0,"order by SortOrder","ѡ����Ŀ"%>
            <input type="submit" value="����" onclick="form.action='?action=content'"/>
            <input type="submit" value="��������" onclick="form.action='?action=allcontent'"/>
      </div>
      </div>
      
    <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
      <div class="main_form_txt"> ��ҳ��</div>
      <div class="main_form_input">                              
            <input type="submit" value="�������е�ҳ" onclick="form.action='?action=about'"/>
      </div>
      </div>	
      </form>
</div>
</body>
</html>