<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_UserFun.asp" -->
<%getContent%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>会员管理</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
    <div class="right_up"></div>
    <div class="right_title"><strong class="txt_C3">查看会员信息</strong></div>
    <div class="main_center_article" id="web_main">
    <div class="main_form"  style=" background:#e8f1f6">
    	<div class="main_form_news_l"><strong>会员信息</strong></div>
    </div>
    <form action="?action=edit&page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
        <div class="main_form_txt">用户名：</div>
        <div class="main_form_input"> 
            <input type="text"  name="UserName" disabled="disabled"  value="<%=UserName%>"/>
            <input type="hidden"  name="UserID" value="<%=UserID%>"/>
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">密码：</div>
        <div class="main_form_input">
            <input type="password"   name="UserPass" /> 不修改密码则不填写
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">分组：</div>
        <div class="main_form_input">
		<%=userGradeSelrct("GradeID",GradeID)%>            
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">真实姓名：</div>
        <div class="main_form_input">             
            <input name="TrueName" type="text" value="<%=TrueName%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">性别：</div>
        <div class="main_form_input">             
            <input type="radio"  value="1" name="Gender" <% if Gender=1 then echo "checked" end if%>/>男
            <input type="radio" value="0" name="Gender" <% if Gender=0 then echo "checked" end if%>/>女
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">联系电话：</div>
        <div class="main_form_input"> 
            <input name="Phone" type="text" value="<%=Phone%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">手机：</div>
        <div class="main_form_input"> 
            <input name="Mobile" type="text" value="<%=Mobile%>" />
        </div>
        </div>
        
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">邮箱：</div>
        <div class="main_form_input"> 
            <input name="Email" type="text" value="<%=Email%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">QQ：</div>
        <div class="main_form_input"> 
            <input name="QQ" type="text" value="<%=QQ%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">地址：</div>
        <div class="main_form_input"> 
            <input name="Address" type="text" style="width:300px" value="<%=Address%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">邮政编码：</div>
        <div class="main_form_input"> 
            <input name="PostCode" type="text" value="<%=PostCode%>" />
        </div>
        </div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">状态：</div>
        <div class="main_form_input"> 
            <input type="checkbox"  value="1" name="UserStatus" <% if UserStatus then echo"checked=""checked"""%>/>
        </div>
        </div>
 
        <div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 保存 " class="btn"/>
		  <input type="button"  value=" 返回 " class="btn" onclick="history.go(-1)"/>
		</div>
		</div>
    </form>
    </div>
</body>
</html>