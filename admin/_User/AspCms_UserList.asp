<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_UserFun.asp" -->
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
  <div class="right_title"><strong class="txt_C3">会员管理</strong></div>
  <div class="main_center_article" id="web_main">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>会员管理</strong></div>
	  	  </div>
	  <form action="?page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
          <div class="maintable">
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0" style=" margin:5px 0px;">
            <tr bgcolor="#FFFFFF" align="center">
                <td style=" height:30px;">用户名：<input type="text" name="keyword" value="<%=keyword%>" style="width:200px;" />&nbsp;&nbsp;<input type="submit" name="selectBtn" value="搜索" class="btn" />        <input type="button" name="selectBtn" value="全部" class="btn"  onclick="location.href='?'" /></td>
            </tr>
        </table>         
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="4%">ID</td>
                <td width="15%">用户名</td>
                <td width="6%">性别</td>
                <td width="15%">邮箱/QQ</td>
                <td width="12%">分组</td>
                <td width="20%">上次登录时间</td>
                <td width="10%">状态</td>
                <td width="14%">操作</td>
                <td width="4%">选择</td>
              </tr>  
              <%userList%>
            </table>
           
        </div>
	</form>
</div>
</body>
</html>