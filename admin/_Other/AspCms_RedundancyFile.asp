<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_FileMangerFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">其它工具-冗余文件检测</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=delallfile&dirpath=<%=dirpath%>" method="post" name="form">
	    <div class="maintable">
<div class="main_form"  style=" background:#e8f1f6">
  <div class="main_form_news_l"><strong>冗余文件检测</strong> <a href="?action=begin" class="txt_C1">开始检测</a></div>
</div>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
  <tr bgcolor="#DDEFF9" align="center">
    <td width="6%">序号</td>
    <td width="23%">文件名称</td>
    <td width="11%">大小</td>
    <td width="14%">类型</td>
    <td width="21%">修改日期</td>
    <td width="14%">操作</td>
    <td width="11%">选择</td>
  </tr>
<%
if action ="begin" then 
	Dim path
	path = "/"&sitePath&"upLoad"	
	getAllFileList path,1	
end if

%>
<tr bgcolor="#FFFFFF" align="right" height="30">
<td colspan="7">
<input type="submit" value="批量删除" onClick="if(confirm('确定要删除吗')){return true;}else{return false}" class="btn"  />全选<input type="checkbox" name="chkall" id="chkall" class="checkbox" onClick="checkAll(this.checked,'input','path')" />反选<input type="checkbox" name="chkothers" id="chkothers" class="checkbox" onClick="checkOthers('input','path')" />&nbsp;&nbsp;</td>
</tr>
</table>

		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong> </strong></div>
  	    </div>
	  </form>
</div>
</body>
</html>

