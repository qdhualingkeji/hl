<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_ContentFun.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����б�</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
<div class="right_up"></div>
<div class="right_title"><strong class="txt_C3">�����б�</strong></div>
<div class="main_center_article" id="web_main">
	<div class="main_form"  style=" background:#e8f1f6">
        <div class="main_form_news_l"><strong><%=styleName%>�б�</strong> | <a href="AspCms_NewsAdd.asp?pic=<%=pic%>&sort=<%=sortID%>"  class="txt_C1">����<%=styleName%></a></div>
    </div>
    <div class="maintable">    
	<form action="?pic=<%=pic%>&page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0" style=" margin:5px 0px;">
            <tr bgcolor="#FFFFFF" align="center">
                <td style=" height:30px;">�ؼ��֣�<input type="text" name="keyword" value="<%=keyword%>" style="width:200px;" />&nbsp;&nbsp;<input type="submit" name="selectBtn" value="����" class="btn" />        <input type="button" name="selectBtn" value="ȫ��" class="btn"  onclick="location.href='?pic=<%=pic%>&sort=<%=sortID%>'" /></td>
            </tr>
        </table>         
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
            <tr bgcolor="#DDEFF9" align="center">
                <td width="5%">ID</td>
                <td width="7%">״̬</td>
                <td width="40%">����</td>
                <td width="8%">��ʾ˳��</td>
                <td width="18%">����ʱ��</td>
                <td width="8%">�����</td>
                <td width="10%">����</td>
                <td width="4%">ѡ��</td>                
            </tr>             
            <%newsList%>
        </table>   
    </form>
    </div>
</div>
</body>
</html>