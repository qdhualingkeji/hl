<!--#include file="AspCms_MainClass.asp" -->
<%
Dim newsID
newsID=filterPara(getForm("id","get"))
Dim rsObj
set rsObj=conn.Exec("select Visits from Aspcms_News where newsID="&newsID&"", "r1")
if not rsObj.eof then echo "document.write("&rsObj(0)&")"
rsObj.close : set rsObj=nothing
%>