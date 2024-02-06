<!--#include file="../inc/AspCms_MainClass.asp" -->
<%
CheckLogin()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>全局优化设置</title>
<link href="css/div.css" rel="stylesheet" type="text/css" />
<link href="css/txt.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="js/common.js"></script>
<script language="javascript" src="js/all.js"></script>
<script language="javascript" src="js/myjs.js"></script></head>

<body>
  <div class="right_up"></div>

  <div class="main_center_article" id="web_main">
  
  
		
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>快捷操作</strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
            <div class="main_form_line">
                <a href="_Setting/AspCms_CompanySetting.asp" class="txt_C1">网站信息设置 </a>
                <a href="_Content/AspCms_NewsSort.asp" class="txt_C1">导航栏目设置</a>
           
                <a href="_Comments/AspCms_Message.asp" class="txt_C1">留言管理 </a>
            
                <a href="_Links/AspCms_Links.asp" class="txt_C1">友情链接设置</a>  
            </div>
		</div>
        
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>网站基本数据统计</strong></div>
	  	  </div>
          
         <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
            <div class="main_form_line">
            <span>文章：<%=getDataCount("select Count(*) from Aspcms_News where SortID in (select SortID from Aspcms_NewsSort where SortStyle=0)")%></span>
        
            <span>留言：<%=getDataCount("select Count(*) from Aspcms_Faq")%></span>
            </div>
		</div>      

	  	
          	
          
	  	
		
          
		<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>站点信息</strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt"> 服务器名称：</div>
		  <div class="main_form_input">
        	名称 <%=Request.ServerVariables("SERVER_NAME")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>) 端口:<%=Request.ServerVariables("SERVER_PORT")%>
		  </div>
          </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">站点物理路径：</div>
		  <div class="main_form_input">
		   <%=Request.ServerVariables("PATH_TRANSLATED")%>
	    </div></div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">FSO文本读写：</div>
		  <div class="main_form_input">
          <%If Not isInstallObj(FSO_OBJ_NAME) Then%><font color="#FF0066"><b>×</b></font><%else%><b>√</b><%end if%>
		  </div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">脚本解释引擎：</div>
		  <div class="main_form_input">
	  	  <%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %>
		  </div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">服务器IIS版本：</div>
		  <div class="main_form_input">
	  	  <%=Request.ServerVariables("SERVER_SOFTWARE")%>
		  </div>
		</div>
 

        <div class="main_form"  style=" background:#e8f1f6">		
        
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt"></div>
		  <div class="main_form_input">
Copyright&copy;  2009-2013  .All Rights Reserved		  </div>
		</div>
  
</div>
</body>
</html>

