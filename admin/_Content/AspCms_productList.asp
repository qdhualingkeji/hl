<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_ContentFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>产品展示-产品列表</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">产品展示-产品列表</strong></div>
  <div class="main_center_article" id="web_main">
    <div class="main_form"  style=" background:#e8f1f6">
        <div class="main_form_news_l"><strong>产品列表</strong> | <a href="AspCms_ProductAdd.asp?sort=<%=sortID%>"  class="txt_C1">发布新产品</a></div>
    </div>
    <div class="maintable">    
	<form action="?page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0" style=" margin:5px 0px;">
            <tr bgcolor="#FFFFFF" align="center">
                <td style=" height:30px;">关键字：<input type="text" name="keyword" value="<%=keyword%>" style="width:200px;" />&nbsp;&nbsp;<input type="submit" name="selectBtn" value="搜索" class="btn" />        <input type="button" name="selectBtn" value="全部" class="btn"  onclick="location.href='?sort=<%=sortID%>'" /></td>
            </tr>
        </table>         
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
            <tr bgcolor="#DDEFF9" align="center">
                <td width="5%">ID</td>
                <td width="7%">状态</td>
                <td width="48%">产品名称</td>
                <td width="8%">显示顺序</td>
                <td width="10%">缩略图</td>
                <td width="8%">置顶</td>
                <td width="10%">操作</td>
                <td width="4%">选择</td>
            </tr>             
            <%productList%>
        </table>   
    </form>
    </div>
</div>
</body>
</html>

