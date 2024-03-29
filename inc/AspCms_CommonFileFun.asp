<%
Function createTextFile(Byval content,Byval fileDir,Byval code)
	dim fileobj,fileCode : fileDir=replace(fileDir, "\", "/")
	if isNul(code) then fileCode="gbk" else fileCode=code
	call createfolder(fileDir,"filedir")
	on error resume next:err.clear
	set fileobj=objFso.CreateTextFile(server.mappath(fileDir),True)
	fileobj.Write(content)
	set fileobj=nothing
	if Err or not isNul(code) then
		err.clear 
		With objStream
			.Charset=fileCode:.Type=2:.Mode=3:.Open:.Position=0
			.WriteText content:.SaveToFile Server.MapPath(fileDir), 2
			.Close
		End With
	end if	
	if Err Then  createTextFile=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_writefile,errid,errdes else createTextFile=true
End Function

Function createStreamFile(Byval stream,Byval fileDir)
	dim errid,errdes
	fileDir=replace(fileDir, "\", "/")
	call createfolder(fileDir,"filedir")
	on error resume next
	With objStream
		.Type =1
		.Mode=3  
		.Open
		.write stream
		.SaveToFile server.mappath(fileDir),2
		.close
	End With
	if Err Then  error.clear:createStreamFile=false else createStreamFile=true
End  Function

Function createFolder(Byval dir,Byval dirType)
	dim subPathArray,lenSubPathArray, pathDeep, i
	on error resume next
	dir=replace(dir, "\", "/")
	dir=replace(server.mappath(dir), server.mappath("/"), "")
	subPathArray=split(dir, "\")
	pathDeep=pathDeep&server.mappath("/")
	select case dirType
		case "filedir"
			 lenSubPathArray=ubound(subPathArray) - 1
		case "folderdir"
			lenSubPathArray=ubound(subPathArray)
	end select
	for i=1 to  lenSubPathArray
		pathDeep=pathDeep&"\"&subPathArray(i)
		if not objFso.FolderExists(pathDeep) then objFso.CreateFolder pathDeep
	next
	if Err Then  createFolder=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_createFolder,errid,errdes else createFolder=true
End Function

Function isExistFile(Byval fileDir)
	on error resume next
	If (objFso.FileExists(server.MapPath(fileDir))) Then  isExistFile=True  Else  isExistFile=False
	if err then err.clear:isExistFile=False
End Function

Function isExistFolder(Byval folderDir)
	on error resume next
	If objFso.FolderExists(server.MapPath(folderDir)) Then  isExistFolder=True Else isExistFolder=False
	if err then err.clear:isExistFolder=False
End Function

Function delFolder(Byval folderDir)
	on error resume next
	If isExistFolder(folderDir)=True Then  
		objFso.DeleteFolder(server.mappath(folderDir)) 
		if Err Then  delFolder=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_delFolder,errid,errdes else delFolder=true
	else
		delFolder=false : die(err_notExistFolder)
	end if
End Function 

Function delFile(Byval fileDir)
	on error resume next
	If isExistFile(fileDir)=True Then objFso.DeleteFile(server.mappath(fileDir))
	if  Err Then  delFile=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_delFile,errid,errdes else delFile=true
End Function 

Function initializeAllObjects()
	dim errid,errdes
	on error resume next
	if not isobject(objFso) then set objFso=server.createobject(FSO_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_fsoobj,errid,errdes
	if not isobject(objStream) then Set objStream=Server.CreateObject(STREAM_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_stmobj,errid,errdes
End Function

Function terminateAllObjects()
	on error resume next
	if conn.isConnect then conn.close
	if isobject(conn) then : set conn=nothing
	if isobject(objFso) then set objFso=nothing
	if isobject(objStream) then set objStream=nothing
	if isobject(cacheObj) then set cacheObj=nothing
	if isobject(mainClassObj) then set mainClassObj=nothing
	if isObject(gXmlHttpObj) then SET gXmlHttpObj=Nothing
End Function

Function moveFolder(oldFolder,newFolder)
	dim voldFolder,vnewFolder
	voldFolder=oldFolder
	vnewFolder=newFolder
	on error resume next
	if voldFolder <> vnewFolder then
		voldFolder=server.mappath(oldFolder)
		vnewFolder=server.mappath(newFolder)
		if not objFso.FolderExists(vnewFolder) then createFolder newFolder,"folderdir" 
		if  objFso.FolderExists(voldFolder)  then  objFso.CopyFolder voldFolder,vnewFolder : objFso.DeleteFolder(voldFolder)
		if Err Then  moveFolder=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_moveFolder,errid,errdes else moveFolder=true
	end if
End Function

Function moveFile(ByVal src,ByVal target,Byval operType)
	dim srcPath,targetPath
	srcPath=Server.MapPath(src) 
	targetPath=Server.MapPath(target)
	if isExistFile(src) then
		objFso.Copyfile srcPath,targetPath
		if operType="del" then  delFile src 
		moveFile=true
	else
		moveFile=false
	end if
End Function

Function getFolderList(Byval cDir)
	dim filePath,objFolder,objSubFolder,objSubFolders,i
	i=0
	redim  folderList(0)
	filePath=server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objSubFolders=objFolder.Subfolders
	for each objSubFolder in objSubFolders
		ReDim Preserve folderList(i)
		With objSubFolder
			folderList(i)=.name&",文件夹,"&.size/1000&"KB,"&.DateLastModified&","&cDir&"/"&.name
		End With
		i=i + 1 
	next 
	set objFolder=nothing
	set objSubFolders=nothing
	getFolderList=folderList
End Function

Function getFileList(Byval cDir)
	dim filePath,objFolder,objFile,objFiles,i
	i=0
	redim  fileList(0)
	filePath=server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objFiles=objFolder.Files
	for each objFile in objFiles
		ReDim Preserve fileList(i)
		With objFile
			fileList(i)=.name&","&Mid(.name, InStrRev(.name, ".") + 1)&","&.size/1000&"KB,"&.DateLastModified&","&cDir&"/"&.name
		End With
		i=i + 1 
	next 
	set objFiles=nothing
	set objFolder=nothing
	getFileList=fileList
End Function

'读取文件内容
Function loadFile(ByVal filePath)
    dim errid,errdes
    On Error Resume Next
    With objStream
        .Type=2
        .Mode=3
        .Open
		.Charset="gbk"
		'die Server.MapPath(filePath)
        .LoadFromFile Server.MapPath(filePath)
        'If Err Then  errid=err.number:errdes=err.description:Err.Clear:echoErr err_loadfile,errid,errdes
        .Position=0
        loadFile=.ReadText
        .Close
    End With
End Function
%>