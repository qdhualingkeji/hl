<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_MessageFun.asp" -->
<%getContent%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>互动管理-留言管理</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
    <div class="right_up"></div>
    <div class="right_title"><strong class="txt_C3">互动管理-留言管理</strong></div>
    <div class="main_center_article" id="web_main">
    <div class="main_form"  style=" background:#e8f1f6">
    	<div class="main_form_news_l"><strong>留言回复</strong></div>
    </div>
    <form action="?action=edit&page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
        <div class="main_form_txt">留言标题：</div>
        <div class="main_form_input"> 
            <input type="text"  style="width:200px" name="FaqTitle" value="<%=FaqTitle%>"/>
            <input type="hidden"  name="faqID" value="<%=faqID%>"/>
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">留言内容：</div>
        <div class="main_form_input"> <textarea name="Content" cols="60" rows="5"><%=Content%></textarea>
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">联系人：</div>
        <div class="main_form_input"> 
            <input name="Contact" type="text" value="<%=Contact%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">联系方式：</div>
        <div class="main_form_input"> 
            <input name="ContactWay" type="text" value="<%=ContactWay%>" />
        </div>
        </div>
        
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">回复：</div>
        <div class="main_form_input"> 
            <textarea name="Reply" cols="60" rows="5"><%=Reply%></textarea>
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">公开：</div>
        <div class="main_form_input"> 
            <input type="checkbox"  value="1" name="FaqStatus" <% if FaqStatus then echo"checked=""checked"""%>/>
        </div>
        </div>
 
        <div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 保存 " class="btn"/>
		</div>
		</div>
    </form>
    </div>
</body>
</html>