<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_ContentFun.asp" -->
<%getContent%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>产品展示-添加产品</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>

<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="Content"]', {
				cssPath : '../kindeditor/plugins/code/prettify.css',
				uploadJson : '../kindeditor/asp/upload_json.asp',
				fileManagerJson : '../kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>

</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">产品展示-添加产品</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editproduct&page=<%=page%>&order=<%=order%>&sort=<%=sortID%>&keyword=<%=keyword%>" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>修改产品</strong> | <span style="cursor:pointer;" onclick="history.go(-1)" class="txt_C1">返回产品列表</span></div>
	  	  </div>
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">产品名称：</div>
		<div class="main_form_input"> 
        	<input type="text" style="width:300px;" name="Title" maxlength="200" value="<%=Title%>"/>
            <input type="hidden" name="NewsID" value="<%=NewsID%>" />
		</div>
		</div>
        <%Call getSpec(id)%>        
        
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">产品缩略图：</div>
		<div class="main_form_input"> <input type="text" name="ImagePath" maxlength="255" id="ImagePath" value="<%=ImagePath%>"/>  <iframe src="../fckeditor/upload.asp?action=news&Tobj=ImagePath" scrolling="no" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="center"></iframe>
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">浏览权限：</div>
		<div class="main_form_input">
		<%=userGradeSelrct("GradeID",GradeID)%>
        <input type="radio" name="Exclusive" value=">=" <% if Exclusive=">=" then echo "checked=""checked""" end if%> />
        隶属
        <input type="radio" name="Exclusive" value="=" <% if Exclusive="=" then echo "checked=""checked""" end if%> /> 
        专属（隶属：权限值≥可查看，专属：权限值=可查看）
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">产品内容：</div>
		<div class="main_form_input">
          <textarea name="Content" cols="40" rows="6" style="width:800px; height:500px;"><%=Content%></textarea> 
  <%'Dim oFCKeditor:Set oFCKeditor = New FCKeditor:oFCKeditor.BasePath="../fckeditor/":oFCKeditor.ToolbarSet="aspcms":oFCKeditor.Width="615":oFCKeditor.Height="300":oFCKeditor.Value=decodeHtml(Content):oFCKeditor.Create "Content"%>  
		</div>
		</div>	
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">关键词：</div>
		<div class="main_form_input"><input type="text" name="NewsTag" maxlength="255"   style="width:500px" value="<%=NewsTag%>"/>         
		</div>
		</div>	
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">描述：</div>
		<div class="main_form_input">  
		  <textarea name="PageDesc" cols="40" rows="6" style="width:500px"><%=PageDesc%></textarea>      
		</div>
		</div>
        <div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">立刻发布：</div>
		<div class="main_form_input"><input type="checkBox" name="NewsStatus"  value="1" <% if NewsStatus then echo"checked=""checked"""%>/>
		</div>
		</div>
		<div class="main_form"><div class="main_form_txt"></div>
		<div class="main_form_input">
		  <input type="submit"  value=" 保 存 " class="btn" />
		</div>
		</div>
	</form>
</div>
</body>
</html>