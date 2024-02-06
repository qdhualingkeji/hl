<!--#include file="../../inc/AspCms_MainClass.asp" -->
<%
CheckLogin()
action = getForm("action", "get")
Dim Tobj : Tobj =getForm("Tobj", "get")
response.write uploadfile()

function uploadfile()
	dim immediate,attachdir,dirtype,maxattachsize,upext
	immediate=Request.QueryString("immediate")
	attachdir="/"+sitePath+"upload"'�ϴ��ļ�����·������β��Ҫ��/
	dirtype=1'1:�������Ŀ¼ 2:���´���Ŀ¼ 3:����չ����Ŀ¼  ����ʹ�ð����
	maxattachsize=20971520'����ϴ���С��Ĭ����2M
	upext="txt,rar,zip,jpg,jpeg,gif,png,swf,wmv,avi,wma,mp3,mid"'�ϴ���չ��
	
	server.ScriptTimeout=600
	
	dim err,msg,upfile
	err = ""
	msg = ""
	
	set upfile=new upfile_class
	upfile.AllowExt=replace(upext,",",";")+";"
	upfile.GetData(maxattachsize)
	if upfile.isErr then
		select case upfile.isErr
		case 1
			err="�������ύ"
		case 2		
			err="�ļ���С���� "+cstr(maxattachsize)+"�ֽ�"
		case else
			err=upfile.ErrMessage
		end select
	else
		dim attach_dir,attach_subdir,filename,extension,target,tmpfile,formName,oFile,fsize
		for each formName in upfile.file '�г������ϴ��˵��ļ�
			set oFile=upfile.file(formname)
			extension=oFile.FileExt
			select case dirtype
				case 1
					attach_subdir="day_"+DateFormat(now,"yymmdd")
				case 2
					attach_subdir="month_"+DateFormat(now,"yymm")
				case 3
					attach_subdir="ext_"+extension
			end select
			attach_dir=attachdir+"/"+attach_subdir+"/"
			'���ļ���
			CreateFolder attach_dir
			tmpfile=upfile.AutoSave(formName,Server.mappath(attach_dir)+"\")
			if upfile.isErr then
				if upfile.isErr=3 then
					err="�ϴ��ļ���չ������Ϊ��"+upext
				else
					err=upfile.ErrMessage
				end if
			else
				'��������ļ���������
				Randomize timer
				filename=DateFormat(now,"yyyymmddhhnnss")+cstr(cint(9999*Rnd))+"."+extension
				target=attach_dir+filename
				moveFile attach_dir+tmpfile,target
				msg=target
				if immediate="1" then msg="!"+msg
			end if
			fsize=oFile.filesize
			set oFile=nothing
		next
	end if
	set upfile=nothing
	if isNul(action) then
	    uploadfile="{err:'"+jsonString(err)+"',msg:'"+jsonString(msg)+"'}"
	else
	    select case action
		    case "news" 
				uploadfile="<script language=""javascript"">parent.document.getElementById("""&Tobj&""").value='"&target&"'</script>" 								
				uploadfile=uploadfile+"<table><tr><td bgcolor=#FFFFFF style=""font-size:12px;""><font color=red>"&filename&"�ϴ��ɹ�![ <span  onclick=history.go(-1)>�����ϴ�</span> ]</font></td></tr></table>"			
			'parent.getElementById.value=path;
		end select
	end if
end function

function jsonString(str)
	str=replace(str,"\","\\")
	str=replace(str,"/","\/")
	str=replace(str,"'","\'")
	jsonString=str
end function

Function Iif(expression,returntrue,returnfalse)
	If expression=true Then
		iif=returntrue
	Else
		iif=returnfalse
	End If
End Function

function DateFormat(strDate,fstr)
	if isdate(strDate) then
		dim i,temp
		temp=replace(fstr,"yyyy",DatePart("yyyy",strDate))
		temp=replace(temp,"yy",mid(DatePart("yyyy",strDate),3))
		temp=replace(temp,"y",DatePart("y",strDate))
		temp=replace(temp,"w",DatePart("w",strDate))
		temp=replace(temp,"ww",DatePart("ww",strDate))
		temp=replace(temp,"q",DatePart("q",strDate))
		temp=replace(temp,"mm",iif(len(DatePart("m",strDate))>1,DatePart("m",strDate),"0"&DatePart("m",strDate)))
		temp=replace(temp,"dd",iif(len(DatePart("d",strDate))>1,DatePart("d",strDate),"0"&DatePart("d",strDate)))
		temp=replace(temp,"hh",iif(len(DatePart("h",strDate))>1,DatePart("h",strDate),"0"&DatePart("h",strDate)))
		temp=replace(temp,"nn",iif(len(DatePart("n",strDate))>1,DatePart("n",strDate),"0"&DatePart("n",strDate)))
		temp=replace(temp,"ss",iif(len(DatePart("s",strDate))>1,DatePart("s",strDate),"0"&DatePart("s",strDate)))
		DateFormat=temp
	else
		DateFormat=false
	end if
end function

Function CreateFolder(FolderPath)
	dim lpath,fs,f
  lpath=Server.MapPath(FolderPath)
  Set fs=Server.CreateObject("Scri"&"pting.File"&"Sys"&"temObject")
  If not fs.FolderExists(lpath) then
	  Set f=fs.CreateFolder(lpath)
	  CreateFolder=F.Path
	end if
  Set F=Nothing
  Set fs=Nothing
 End Function
 
Function moveFile(oldfile,newfile)
	dim fs
 Set fs=Server.CreateObject("Scri"&"pting.File"&"Sys"&"temObject")
 fs.movefile Server.MapPath(oldfile),Server.MapPath(newfile)
 Set fs=Nothing
End Function
 
'----------------------------------------------------------------------
'�ļ��ϴ���
Class UpFile_Class

Dim Form,File
Dim AllowExt_
Dim NoAllowExt_
Dim IsDebug_
Private	oUpFileStream
Private isErr_
Private ErrMessage_
Private isGetData_

'------------------------------------------------------------------
'�������
Public Property Get Version
	Version="�޾��ϴ��� Version V2.0"
End Property

Public Property Get isErr
	isErr=isErr_
End Property

Public Property Get ErrMessage
	ErrMessage=ErrMessage_
End Property

Public Property Get AllowExt
	AllowExt=AllowExt_
End Property

Public Property Let AllowExt(Value)
	AllowExt_=LCase(Value)
End Property

Public Property Get NoAllowExt
	NoAllowExt=NoAllowExt_
End Property

Public Property Let NoAllowExt(Value)
	NoAllowExt_=LCase(Value)
End Property

Public Property Let IsDebug(Value)
	IsDebug_=Value
End Property


'----------------------------------------------------------------
'��ʵ�ִ���

'��ʼ����
Private Sub Class_Initialize
	isErr_ = 0
	NoAllowExt="asp;asa;cer;aspx;php;"
	NoAllowExt=LCase(NoAllowExt)
	AllowExt=""
	AllowExt=LCase(AllowExt)
	isGetData_=false
End Sub

'�����
Private Sub Class_Terminate	
	on error Resume Next
	'�������������
	Form.RemoveAll
	Set Form = Nothing
	File.RemoveAll
	Set File = Nothing
	oUpFileStream.Close
	Set oUpFileStream = Nothing
	if Err.number<>0 then OutErr("�����ʱ��������!")
End Sub

'�����ϴ�������
Public Sub GetData (MaxSize)
	 '�������
	on error Resume Next
	if isGetData_=false then 
		Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
		Dim sFormValue,sFileName
		Dim iFindStart,iFindEnd
		Dim iFormStart,iFormEnd,sFormName
		'���뿪ʼ
		If Request.TotalBytes < 1 Then	'���û�������ϴ�
			isErr_ = 1
			ErrMessage_="û�������ϴ�,������Ϊֱ���ύ��ַ�������Ĵ���!"
			OutErr("û�������ϴ�,������Ϊֱ���ύ��ַ�������Ĵ���!!")
			Exit Sub
		End If
		If MaxSize > 0 Then '������ƴ�С
			If Request.TotalBytes > MaxSize Then
			isErr_ = 2	'����ϴ������ݳ������ƴ�С
			ErrMessage_="�ϴ������ݳ������ƴ�С!"
			OutErr("�ϴ������ݳ������ƴ�С!")
			Exit Sub
			End If
		End If
		Set Form = Server.CreateObject ("Scripting.Dictionary")
		Form.CompareMode = 1
		Set File = Server.CreateObject ("Scripting.Dictionary")
		File.CompareMode = 1
		Set tStream = Server.CreateObject ("ADODB.Stream")
		Set oUpFileStream = Server.CreateObject ("ADODB.Stream")
		if Err.number<>0 then OutErr("����������(ADODB.STREAM)ʱ����,����ϵͳ��֧�ֻ�û�п�ͨ�����")
		oUpFileStream.Type = 1
		oUpFileStream.Mode = 3
		oUpFileStream.Open 
		oUpFileStream.Write Request.BinaryRead (Request.TotalBytes)
		oUpFileStream.Position = 0
		RequestBinDate = oUpFileStream.Read 
		iFormEnd = oUpFileStream.Size
		bCrLf = ChrB (13) & ChrB (10)
		'ȡ��ÿ����Ŀ֮��ķָ���
		sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1)
		iStart = LenB(sSpace)
		iFormStart = iStart+2
		'�ֽ���Ŀ
		Do
			iInfoEnd = InStrB (iFormStart,RequestBinDate,bCrLf & bCrLf)+3
			tStream.Type = 1
			tStream.Mode = 3
			tStream.Open
			oUpFileStream.Position = iFormStart
			oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart
			tStream.Position = 0
			tStream.Type = 2
			tStream.CharSet = "gb2312"
			sInfo = tStream.ReadText			
			'ȡ�ñ�����Ŀ����
			iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1
			iFindStart = InStr (22,sInfo,"name=""",1)+6
			iFindEnd = InStr (iFindStart,sInfo,"""",1)
			sFormName = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
			'������ļ�
			If InStr (45,sInfo,"filename=""",1) > 0 Then
				Set oFileInfo = new FileInfo_Class
				'ȡ���ļ�����
				iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10
				iFindEnd = InStr (iFindStart,sInfo,""""&vbCrLf,1)
				sFileName = Trim(Mid(sinfo,iFindStart,iFindEnd-iFindStart))
				oFileInfo.FileName = GetFileName(sFileName)
				oFileInfo.FilePath = GetFilePath(sFileName)
				oFileInfo.FileExt = GetFileExt(sFileName)
				iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14
				iFindEnd = InStr (iFindStart,sInfo,vbCr)
				oFileInfo.FileMIME = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
				oFileInfo.FileStart = iInfoEnd
				oFileInfo.FileSize = iFormStart -iInfoEnd -2
				oFileInfo.FormName = sFormName
				file.add sFormName,oFileInfo
			else
			'����Ǳ�����Ŀ
				tStream.Close
				tStream.Type = 1
				tStream.Mode = 3
				tStream.Open
				oUpFileStream.Position = iInfoEnd 
				oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2
				tStream.Position = 0
				tStream.Type = 2
				tStream.CharSet = "gb2312"
				sFormValue = tStream.ReadText
				If Form.Exists (sFormName) Then
					Form (sFormName) = Form (sFormName) & ", " & sFormValue
					else
					Form.Add sFormName,sFormValue
				End If
			End If
			tStream.Close
			iFormStart = iFormStart+iStart+2
			'������ļ�β�˾��˳�
		Loop Until (iFormStart+2) >= iFormEnd 
		if Err.number<>0 then OutErr("�ֽ��ϴ�����ʱ��������,���ܿͻ��˵��ϴ����ݲ���ȷ�򲻷����ϴ����ݹ���")
		RequestBinDate = ""
		Set tStream = Nothing
		isGetData_=true
	end if
End Sub

'���浽�ļ�,�Զ������Ѵ��ڵ�ͬ���ļ�
Public Function SaveToFile(Item,Path)
	SaveToFile=SaveToFileEx(Item,Path,True)
End Function

'���浽�ļ�,�Զ������ļ���
Public Function AutoSave(Item,Path)
	AutoSave=SaveToFileEx(Item,Path,false)
End Function

'���浽�ļ�,OVERΪ��ʱ,�Զ������Ѵ��ڵ�ͬ���ļ�,�����Զ����ļ���������
Private Function SaveToFileEx(Item,Path,Over)
	On Error Resume Next
	Dim FileExt
	if file.Exists(Item) then
		Dim oFileStream
		Dim tmpPath
		isErr_=0
		Set oFileStream = CreateObject ("ADODB.Stream")
		oFileStream.Type = 1
		oFileStream.Mode = 3
		oFileStream.CharSet = "gb2312"
		oFileStream.Open
		oUpFileStream.Position = File(Item).FileStart
		oUpFileStream.CopyTo oFileStream,File(Item).FileSize
		tmpPath=Split(Path,".")(0)
		FileExt=GetFileExt(Path)
		if Over then
			if isAllowExt(FileExt) then
				oFileStream.SaveToFile tmpPath & "." & FileExt,2
				if Err.number<>0 then OutErr("�����ļ�ʱ����,����·��,�Ƿ���ڸ��ϴ�Ŀ¼!���ļ�����·��Ϊ" & tmpPath & "." & FileExt)
			Else
				isErr_=3
				ErrMessage_="�ú�׺�����ļ��������ϴ�!"
				OutErr("�ú�׺�����ļ��������ϴ�")
			End if
		Else
			Path=GetFilePath(Path)
			dim fori
			fori=1
			if isAllowExt(File(Item).FileExt) then
				do
					fori=fori+1
					Err.Clear()
					tmpPath=Path&GetNewFileName()&"."&File(Item).FileExt
					oFileStream.SaveToFile tmpPath
				loop Until ((Err.number=0) or (fori>50))
				if Err.number<>0 then OutErr("�Զ������ļ�����,�Ѿ�����50�β�ͬ���ļ���������,����Ŀ¼�Ƿ����!���ļ����һ�α���ʱȫ·��Ϊ"&Path&GetNewFileName()&"."&File(Item).FileExt)
			Else
				isErr_=3
				ErrMessage_="�ú�׺�����ļ��������ϴ�!"
				OutErr("�ú�׺�����ļ��������ϴ�")
			End if
		End if
		oFileStream.Close
		Set oFileStream = Nothing
	else
		ErrMessage_="�����ڸö���(����ļ�û���ϴ�,�ļ�Ϊ��)!"
		OutErr("�����ڸö���(����ļ�û���ϴ�,�ļ�Ϊ��)")
	end if
	if isErr_=3 then SaveToFileEx="" else SaveToFileEx=GetFileName(tmpPath)
End Function

'ȡ���ļ�����
Public Function FileData(Item)
	isErr_=0
	if file.Exists(Item) then
		if isAllowExt(File(Item).FileExt) then
			oUpFileStream.Position = File(Item).FileStart
			FileData = oUpFileStream.Read (File(Item).FileSize)
			Else
			isErr_=3
			ErrMessage_="�ú�׺�����ļ��������ϴ�"
			OutErr("�ú�׺�����ļ��������ϴ�")
			FileData=""
		End if
	else
		ErrMessage_="�����ڸö���(����ļ�û���ϴ�,�ļ�Ϊ��)!"
		OutErr("�����ڸö���(����ļ�û���ϴ�,�ļ�Ϊ��)")
	end if
End Function


'ȡ���ļ�·��
Public function GetFilePath(FullPath)
  If FullPath <> "" Then
    GetFilePath = Left(FullPath,InStrRev(FullPath, "\"))
    Else
    GetFilePath = ""
  End If
End function

'ȡ���ļ���
Public Function GetFileName(FullPath)
  If FullPath <> "" Then
    GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
    Else
    GetFileName = ""
  End If
End function

'ȡ���ļ��ĺ�׺��
Public Function GetFileExt(FullPath)
  If FullPath <> "" Then
    GetFileExt = LCase(Mid(FullPath,InStrRev(FullPath, ".")+1))
    Else
    GetFileExt = ""
  End If
End function

'ȡ��һ�����ظ������
Public Function GetNewFileName()
	dim ranNum
	dim dtNow
	dtNow=Now()
	randomize
	ranNum=int(90000*rnd)+10000
	'���������webboy�ṩ
	GetNewFileName=year(dtNow) & right("0" & month(dtNow),2) & right("0" & day(dtNow),2) & right("0" & hour(dtNow),2) & right("0" & minute(dtNow),2) & right("0" & second(dtNow),2) & ranNum
End Function

Public Function isAllowExt(Ext)
	if NoAllowExt="" then
		isAllowExt=cbool(InStr(1,";"&AllowExt&";",LCase(";"&Ext&";")))
	else
		isAllowExt=not CBool(InStr(1,";"&NoAllowExt&";",LCase(";"&Ext&";")))
	end if
End Function
End Class

Public Sub OutErr(ErrMsg)
if IsDebug_=true then
	Response.Write ErrMsg
	Response.End
	End if
End Sub

'----------------------------------------------------------------------------------------------------
'�ļ�������
Class FileInfo_Class
Dim FormName,FileName,FilePath,FileSize,FileMIME,FileStart,FileExt
End Class
%>