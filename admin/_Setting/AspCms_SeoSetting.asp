<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_SettingFun.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>全局优化设置</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script></head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">全局优化设置</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editseo" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>优化设置</strong></div>
	  	  </div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">运行模式：</div>
		  <div class="main_form_input">
		    <select name="runMode" id="runMode">
		      <option value="0" <% if runMode="0" then echo "selected"%>>动态</option>
		      <option value="1" <% if runMode="1" then echo "selected"%>>静态</option>
            </select>
		  </div></div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">网页附加标题：</div>
		  <div class="main_form_input">
		    <input type="text" name="additionTitle" class="my_input" style="width:400px" value="<%=additionTitle%>"/>
	    </div></div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">网站关键词：</div>
		  <div class="main_form_input">
	  	  <input type="text" name="siteKeyWords" class="my_input" style="width:400px" value="<%=siteKeyWords%>"/>
		  </div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">网站主要描述：</div>
		  <div class="main_form_input">
		    <textarea name="siteDesc" cols="40" rows="6" style="width:500px"><%=decode(siteDesc)%></textarea>
		  </div></div>
          
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">生成RSS：</div>
		  <div class="main_form_input">
		    <input type="submit"  value="生成RSS" onclick="form.action='?action=rss'" />
            <a href="/<%=sitePath%>rssmap.html" target="_blank" class="txt_C1">浏览/rssmap.html</a>
		  </div>
		</div>		
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">生成SiteMap：</div>
		  <div class="main_form_input">
		    <input type="submit"  value="生成SiteMap" onclick="form.action='?action=sitemap'" />            
            <a href="/<%=sitePath%>sitemap.html" target="_blank" class="txt_C1">浏览/sitemap.html</a>
		  </div>
		</div>
          
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">生成百度SiteMap：</div>
		  <div class="main_form_input">
		    <input type="submit"  value="生成百度SiteMap"  onclick="form.action='?action=baidu'" />
		  </div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''">
		  <div class="main_form_txt">生成GoogleSiteMap：</div>
		  <div class="main_form_input">
		    <input type="submit"  value="生成GoogleSiteMap" onclick="form.action='?action=google'" />
		  </div>
		</div>		
        		
        
        
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 保 存 " />
		</div>
		</div>
	</form>
</div>
</body>
</html>

