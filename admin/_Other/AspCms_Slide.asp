<!--#include file="../../inc/AspCms_MainClass.asp" -->
<!--#include file="AspCms_OtherFun.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>其他工具-幻灯片管理</title>
<link href="../css/div.css" rel="stylesheet" type="text/css" />
<link href="../css/txt.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script language="javascript" src="../js/common.js"></script>
<script language="javascript" src="../js/all.js"></script>
<script language="javascript" src="../js/myjs.js"></script>
</head>

<body>
  <div class="right_up"></div>
  <div class="right_title"><strong class="txt_C3">其他工具-幻灯片管理</strong></div>
  <div class="main_center_article" id="web_main">
	  <form action="?action=editslide" method="post" name="form">
	  	<div class="main_form"  style=" background:#e8f1f6">
	  	  <div class="main_form_news_l"><strong>幻灯片管理</strong></div>
  	    </div>
          <div class="maintable">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#a9c5d0" id="">
              <tr bgcolor="#DDEFF9" align="center">
                <td width="40%">ID</td>
                <td width="60%">状态</td>
              </tr>
			<%
            Dim slideImg,slideLink,slideText,i,imgstr
            slideImg = split(slideImgs,",")
            slideLink = split(slideLinks,",")
            slideText = split(slideTexts,",")
            
            for i=0 to ubound(slideImg)				
				if isnul(trim(slideImg(i))) then
					imgstr="这里插入一张图片"
				else
					imgstr="<img src="""&trim(slideImg(i))&""" width=""160px"" height=""120px"" />"
				end if			
            %>
              <tr align="center" bgcolor="#FFFFFF">
            	<td class="pic"><%=imgstr%></td>
                <td align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">                
                  <tr>
                    <td width="18%" align="right">图片地址：</td>
                    <td width="82%"><input type="text" name="slideImgs" id="ImagePath<%=i%>" value="<%=trim(slideImg(i))%>"/></td>
                  </tr>
                  <tr>
                    <td align="right">上传图片：</td>
                    <td><iframe src="../fckeditor/upload.asp?action=news&amp;Tobj=ImagePath<%=i%>" scrolling="No" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="left"></iframe></td>
                  </tr>
                  <tr>
                    <td align="right">链接地址：</td>
                    <td><input type="text" name="slideLinks"  value="<%=trim(slideLink(i))%>"/>空链接则填"#"</td>
                  </tr>
                  <tr>
                    <td align="right">说明文字： </td>
                    <td><input type="text" name="slideTexts"  value="<%=trim(slideText(i))%>"/></td>
                  </tr>
                </table></td>
              </tr>
              <%
			  next
			  %>                        
            </table>        
                
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">幻灯片大小：</div>
		<div class="main_form_input"> 
		  宽：<input type="text" name="slideWidth" value="<%=slideWidth%>" style="width:40px" />
		  高：<input type="text" name="slideHeight" value="<%=slideHeight%>" style="width:40px" />
         
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">文字说明：</div>
		<div class="main_form_input"> 
	 <input type="radio"  value="1" name="slideTextStatus" <% if slideTextStatus=1 then echo "checked" end if%>/>显示
            <input type="radio" value="0" name="slideTextStatus" <% if slideTextStatus=0 then echo "checked" end if%>/>隐藏         
		</div>
		</div>
		<div class="main_form" onmouseover="this.style.backgroundColor='#e8f1f6'" onmouseout="this.style.backgroundColor=''"><div class="main_form_txt">幻灯片调用标签：</div>
		<div class="main_form_input"> 
	 			{aspcms:slide}         
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