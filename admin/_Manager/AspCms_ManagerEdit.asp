<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_ManagerFun.asp" -->
<%getContent%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>系统相关设置-管理员权限设置</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">系统相关设置-管理员权限设置</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=edit" method="post" name="form">
        <div class="main_form" style=" background:#e8f1f6"	>
	  	  <div class="main_form_news_l"><strong>修改管理员信息 </strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">登录名：</div>
		<div class="main_form_input"> 
        	<%=UserName%><input type="hidden" name="AdminID" value="<%=AdminID%>" />
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">是否生效：</div>
		<div class="main_form_input"> 
        	<input type="checkBox" name="AdminStatus" value="1" <% if AdminStatus then echo"checked=""checked"""%> />
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">新密码：</div>
		<div class="main_form_input"> 
			<input type="password" style="width:200px;" name="Password"/> 不填新密码则不会修改密码
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">确认密码：</div>
		<div class="main_form_input"> 
			<input type="password" style="width:200px;" name="rePassword"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">管理员姓名：</div>
		<div class="main_form_input"> 
        	<input type="text"  style="width:200px" name="RealName" value="<%=RealName%>"/>
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">操作权限：</div>
		<div class="main_form_input"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><strong>系统相关设置</strong></td>
    <td><strong>网站信息设置</strong></td>
    <td><strong>会员管理</strong></td>
    <td><strong>互动管理</strong></td>
    <td><strong>其它工具</strong></td>
    <td><strong>风格模板管理</strong></td>
  </tr>
  <tr>
    <td valign="top">
        <label for="c11"><input type="checkbox"  id="c11" name="Permissions" <%if instr(Permissions,"AspCms_CompanySetting.asp")>0 then  echo "checked=""checked""" %> value="AspCms_CompanySetting.asp" /> 网站信息设置</label></label><br />
        <label for="c12"><input type="checkbox"  id="c12" name="Permissions" <%if instr(Permissions,"AspCms_NewsSort.asp,AspCms_NewsSortEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_NewsSort.asp,AspCms_NewsSortEdit.asp" /> 导航栏目设置</label><br />
        <label for="c13"><input type="checkbox"  id="c13" name="Permissions" <%if instr(Permissions,"AspCms_ProductSpec.asp")>0 then  echo "checked=""checked""" %> value="AspCms_ProductSpec.asp" /> 产品参数设置</label><br />
        <label for="c14"><input type="checkbox"  id="c14" name="Permissions" <%if instr(Permissions,"AspCms_OnlineService.asp")>0 then  echo "checked=""checked""" %> value="AspCms_OnlineService.asp" /> 在线客服设置</label><br />
        <label for="c15"><input type="checkbox"  id="c15" name="Permissions" <%if instr(Permissions,"AspCms_ADSetting.asp")>0 then  echo "checked=""checked""" %> value="AspCms_ADSetting.asp" /> 网站广告设置</label><br />
        <label for="c16"><input type="checkbox"  id="c16" name="Permissions" <%if instr(Permissions,"AspCms_Links.asp,AspCms_LinksEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Links.asp,AspCms_LinksEdit.asp" /> 友情链接设置</label><br />
        <label for="c17"><input type="checkbox"  id="c17" name="Permissions" <%if instr(Permissions,"AspCms_SeoSetting.asp")>0 then  echo "checked=""checked""" %> value="AspCms_SeoSetting.asp" /> 全局优化设置</label><br />
        <label for="c18"><input type="checkbox"  id="c18" name="Permissions" <%if instr(Permissions,"AspCms_CopyRight.asp")>0 then  echo "checked=""checked""" %> value="AspCms_CopyRight.asp" /> 网站版权设置</label><br />
        <label for="c19"><input type="checkbox"  id="c19" name="Permissions" <%if instr(Permissions,"AspCms_Manager.asp,AspCms_ManagerEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Manager.asp,AspCms_ManagerEdit.asp" /> 管理员权限设置</label><br />
        <label for="c191"><input type="checkbox"  id="c191" name="Permissions" <%if instr(Permissions,"AspCms_Data.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Data.asp" /> 数据库备份/恢复</label><br />
	</td>
    <td valign="top">
        <label for="c21"><input type="checkbox"  id="c21" name="Permissions" <%if instr(Permissions,"AspCms_BaseAdd.asp")>0 then  echo "checked=""checked""" %> value="AspCms_BaseAdd.asp" /> 单篇文章</label><br />
        <label for="c22"><input type="checkbox"  id="c22" name="Permissions" <%if instr(Permissions,"AspCms_NewsList.asp,AspCms_NewsAdd.asp,AspCms_NewsEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_NewsList.asp,AspCms_NewsAdd.asp,AspCms_NewsEdit.asp" /> 文章/图片列表</label><br />
        <label for="c23"><input type="checkbox"  id="c23" name="Permissions" <%if instr(Permissions,"AspCms_productList.asp,AspCms_ProductAdd.asp,AspCms_ProductEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_productList.asp,AspCms_ProductAdd.asp,AspCms_ProductEdit.asp" /> 产品列表</label><br />
        <label for="c24"><input type="checkbox"  id="c24" name="Permissions" <%if instr(Permissions,"AspCms_DownList.asp,AspCms_DownAdd.asp,AspCms_DownEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_DownList.asp,AspCms_DownAdd.asp,AspCms_DownEdit.asp" /> 下载列表</label><br />
    </td>
    
    <td valign="top">
        <label for="c61"><input type="checkbox"  id="c61" name="Permissions"  <%if instr(Permissions,"AspCms_GradeEdit.asp,AspCms_Grades.asp")>0 then  echo "checked=""checked""" %> value="AspCms_GradeEdit.asp,AspCms_Grades.asp" /> 会员等级管理 </label><br />
        <label for="c62"><input type="checkbox"  id="c62" name="Permissions"  <%if instr(Permissions,"AspCms_UserEdit.asp,AspCms_UserList.asp")>0 then  echo "checked=""checked""" %> value="AspCms_UserEdit.asp,AspCms_UserList.asp" /> 会员管理 </label><br /><br />      
        
    </td>
    <td valign="top">
        <label for="c31"><input type="checkbox"  id="c31" name="Permissions" <%if instr(Permissions,"AspCms_Message.asp,AspCms_MessageEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Message.asp,AspCms_MessageEdit.asp" /> 留言管理 </label><br />        
        <label for="c32"><input type="checkbox"  id="c32" name="Permissions" <%if instr(Permissions,"AspCms_Comment.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Comment.asp" /> 评论管理 </label><br />
        
        <label for="c33"><input type="checkbox"  id="c33" name="Permissions" <%if instr(Permissions,"AspCms_OrderEdit.asp,AspCms_Orders.asp")>0 then  echo "checked=""checked""" %> value="AspCms_OrderEdit.asp,AspCms_Orders.asp" /> 订单管理 </label><br />
        
        
    </td>
    <td valign="top">
        <label for="c41"><input type="checkbox"  id="c41" name="Permissions" <%if instr(Permissions,"AspCms_Slide.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Slide.asp" /> 幻灯片管理</label><br />
        <label for="c42"><input type="checkbox"  id="c42" name="Permissions" <%if instr(Permissions,"AspCms_FileManger.asp")>0 then  echo "checked=""checked""" %> value="AspCms_FileManger.asp" /> 上传文件管理</label><br />
        <label for="c47"><input type="checkbox"  id="c47" name="Permissions" <%if instr(Permissions,"AspCms_RedundancyFile.asp")>0 then  echo "checked=""checked""" %> value="AspCms_RedundancyFile.asp" /> 冗余文件检测</label><br />
        <label for="c43"><input type="checkbox"  id="c43" name="Permissions" <%if instr(Permissions,"AspCms_Statistics.asp")>0 then  echo "checked=""checked""" %> value="AspCms_Statistics.asp" /> 网站访问统计</label><br />
        <label for="c44"><input type="checkbox"  id="c44" name="Permissions" <%if instr(Permissions,"AspCms_SearchEngine.asp")>0 then  echo "checked=""checked""" %> value="AspCms_SearchEngine.asp" /> 搜索引擎登录</label><br />

    </td>
    <td valign="top">
        <label for="c51"><input type="checkbox"  id="c51" name="Permissions" <%if instr(Permissions,"AspCms_StyleManage.asp")>0 then  echo "checked=""checked""" %> value="AspCms_StyleManage.asp" /> 选择模板 </label><br /> 		
        <label for="c52"><input type="checkbox"  id="c52" name="Permissions" <%if instr(Permissions,"AspCms_TemplateManger.asp,AspCms_TemplateAdd.asp,AspCms_TemplateEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_TemplateManger.asp,AspCms_TemplateAdd.asp,AspCms_TemplateEdit.asp" /> 模板管理 </label><br />   	
        <label for="c52"><input type="checkbox"  id="c52" name="Permissions" <%if instr(Permissions,"AspCms_CssManger.asp,AspCms_CssAdd.asp,AspCms_CssEdit.asp")>0 then  echo "checked=""checked""" %> value="AspCms_CssManger.asp,AspCms_CssAdd.asp,AspCms_CssEdit.asp" /> 样式文件管理 </label>

    </td>
  </tr>
</table>

		</div>
		</div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">备注说明：</div>
		<div class="main_form_input"><textarea type="text" name="AdminDesc" cols="40" rows="6" style="width:500px"><%=AdminDesc%></textarea>         
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