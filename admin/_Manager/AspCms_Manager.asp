<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_ManagerFun.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ϵͳ�������-����ԱȨ������</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">ϵͳ�������-����ԱȨ������</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=add" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>����Ա�б�</strong></div>
	  	  </div>
          <div class="maintable">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="4%">ID</td>
                <td width="10%">״̬</td>
                <td width="13%">�û���</td>
                <td width="15%">����</td>
                <td width="22%">����¼ʱ��</td>
                <td width="15%">����¼IP</td>
                <td width="21%">����</td>
              </tr>
              <%AdminList%>
            </table>
            
		</div>
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>���ӹ���Ա </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��¼����</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="UserName" />
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">�Ƿ���Ч��</div>
	  <div class="main_form_input"> 
        	<input type="checkBox" name="AdminStatus" value="1" checked />
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">���룺</div>
		<div class="main_form_input"> 
			<input type="password" style="width:200px;" name="Password"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">ȷ�����룺</div>
		<div class="main_form_input"> 
			<input type="password" style="width:200px;" name="rePassword"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">����Ա������</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="RealName"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">����Ȩ�ޣ�</div>
		<div class="main_form_input">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><strong>ϵͳ�������</strong></td>
    <td><strong>��վ��Ϣ����</strong></td>
    <td><strong>��Ա����</strong></td>
    <td><strong>��������</strong></td>
    <td><strong>��������</strong></td>
    <td><strong>���ģ�����</strong></td>
  </tr>
  <tr>
    <td valign="top">
        <label for="c11"><input type="checkbox"  id="c11" name="Permissions" checked="checked" value="AspCms_CompanySetting.asp" /> ��վ��Ϣ����</label></label><br />
        <label for="c12"><input type="checkbox"  id="c12" name="Permissions" value="AspCms_NewsSort.asp,AspCms_NewsSortEdit.asp" /> ������Ŀ����</label><br />
        <label for="c13"><input type="checkbox"  id="c13" name="Permissions" value="AspCms_ProductSpec.asp" /> ��Ʒ��������</label><br />
        <label for="c14"><input type="checkbox"  id="c14" name="Permissions" checked="checked" value="AspCms_OnlineService.asp" /> ���߿ͷ�����</label><br />
        <label for="c15"><input type="checkbox"  id="c15" name="Permissions" checked="checked" value="AspCms_ADSetting.asp" /> ��վ�������</label><br />
        <label for="c16"><input type="checkbox"  id="c16" name="Permissions" checked="checked" value="AspCms_Links.asp,AspCms_LinksEdit.asp" /> ������������</label><br />
        <label for="c17"><input type="checkbox"  id="c17" name="Permissions" checked="checked" value="AspCms_SeoSetting.asp" /> ȫ���Ż�����</label><br />
        <label for="c18"><input type="checkbox"  id="c18" name="Permissions" value="AspCms_CopyRight.asp" /> ��վ��Ȩ����</label><br />
        <label for="c19"><input type="checkbox"  id="c19" name="Permissions" value="AspCms_Manager.asp,AspCms_ManagerEdit.asp" /> ����ԱȨ������</label><br />
        <label for="c191"><input type="checkbox"  id="c191" name="Permissions" checked="checked" value="AspCms_Data.asp" /> ���ݿⱸ��/�ָ�</label><br />
	</td>
    <td valign="top">
        <label for="c21"><input type="checkbox"  id="c21" name="Permissions" checked="checked" value="AspCms_BaseAdd.asp" /> ��ƪ����</label><br />
        <label for="c22"><input type="checkbox"  id="c22" name="Permissions" checked="checked" value="AspCms_NewsList.asp,AspCms_NewsAdd.asp,AspCms_NewsEdit.asp" /> ����/ͼƬ�б�</label><br />
        <label for="c23"><input type="checkbox"  id="c23" name="Permissions" checked="checked" value="AspCms_productList.asp,AspCms_ProductAdd.asp,AspCms_ProductEdit.asp" /> ��Ʒ�б�</label><br />
        <label for="c24"><input type="checkbox"  id="c24" name="Permissions" checked="checked" value="AspCms_DownList.asp,AspCms_DownAdd.asp,AspCms_DownEdit.asp" /> �����б�</label><br />
    </td>
    <td valign="top">
        <label for="c61"><input type="checkbox"  id="c61" name="Permissions" checked="checked" value="AspCms_GradeEdit.asp,AspCms_Grades.asp" /> ��Ա�ȼ����� </label><br />
        <label for="c62"><input type="checkbox"  id="c62" name="Permissions" checked="checked" value="AspCms_UserEdit.asp,AspCms_UserList.asp" /> ��Ա���� </label><br /><br />      
        
    </td>
    <td valign="top">
        <label for="c31"><input type="checkbox"  id="c31" name="Permissions" checked="checked" value="AspCms_Message.asp,AspCms_MessageEdit.asp" /> ���Թ��� </label><br />
        <label for="c32"><input type="checkbox"  id="c32" name="Permissions" checked="checked" value="AspCms_Comment.asp" /> ���۹��� </label><br />
        <label for="c33"><input type="checkbox"  id="c33" name="Permissions" checked="checked" value="AspCms_OrderEdit.asp,AspCms_Orders.asp" /> �������� </label><br />
        
        
    </td>
    <td valign="top">
        <label for="c41"><input type="checkbox"  id="c41" name="Permissions" checked="checked" value="AspCms_Slide.asp" /> �õ�Ƭ����</label><br />
        <label for="c42"><input type="checkbox"  id="c42" name="Permissions" checked="checked" value="AspCms_FileManger.asp" /> �ϴ��ļ�����</label><br />
        <label for="c47"><input type="checkbox"  id="c47" name="Permissions" checked="checked" value="AspCms_RedundancyFile.asp" /> �����ļ����</label><br />
        <label for="c43"><input type="checkbox"  id="c43" name="Permissions" checked="checked" value="AspCms_Statistics.asp" /> ��վ����ͳ��</label><br />
        <label for="c44"><input type="checkbox"  id="c44" name="Permissions" checked="checked" value="AspCms_SearchEngine.asp" /> ���������¼</label><br />
    </td>
    <td valign="top">
        <label for="c51"><input type="checkbox"  id="c51" name="Permissions" checked="checked" value="AspCms_StyleManage.asp" /> ѡ��ģ�� </label><br />
        <label for="c52"><input type="checkbox"  id="c52" name="Permissions" checked="checked" value="AspCms_TemplateManger.asp,AspCms_TemplateAdd.asp,AspCms_TemplateEdit.asp" /> ģ����� </label><br />
        <label for="c53"><input type="checkbox"  id="c53" name="Permissions" checked="checked" value="AspCms_CssManger.asp,AspCms_CssAdd.asp,AspCms_CssEdit.asp" /> ��ʽ�ļ����� </label><br />
    </td>
  </tr>
</table>
		</div>
		</div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">��ע˵����</div>
		<div class="main_form_input"><textarea type="text" name="AdminDesc" cols="40" rows="6" style="width:500px"></textarea>         
		</div>
		</div>	
        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" �� �� " class="btn"/>
		</div>
		</div>
        
</form>
</div>
</body>
</html>