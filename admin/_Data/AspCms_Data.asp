<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_DataFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>系统相关设置-数据库备份恢复</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">系统相关设置-数据库备份恢复</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=delall" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>备份数据库</strong>（<a href="?action=bakup" class="txt_C1">开始备份</a>）</div>
	  	  </div>
          <div class="maintable">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="10%">序号</td>
                <td width="35%">文件名称</td>
                <td width="25%">备份时间</td>
                <td width="20%">操作</td>
                <td width="10%">选择</td>
              </tr>
              <%databackList%>
            </table>
		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>压缩优化数据库 </strong>（压缩前最好先[备份]数据库，正在使用中的数据库不能被压缩）</div>
	  	  </div>
		<div class="main_form" onMouseOver="this.style.backgroundColor='#e8f1f6'" onMouseOut="this.style.backgroundColor=''"><div class="main_form_txt"></div>
		<div class="main_form_input"> 
        	<a href="?action=compress" class="txt_C1">压缩优化数据库</a>            
		</div>
		</div>
        
	</form>
</div>
</body>
</html>