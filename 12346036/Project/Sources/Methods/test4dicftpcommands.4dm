//%attributes = {}
// method describes 4DIC bug sending file just with filename, not using full path

// #ORDA
C_OBJECT:C1216($serverprefs)
C_TEXT:C284($fileName; $path; $FTP_Msg; $fullpath)
C_TEXT:C284($sourcePath; $hostDirectory; $hostName; $userName; $password; $errtxt)
C_BOOLEAN:C305($ok)
C_LONGINT:C283($ftpid; $error)

$fileName:=c_rateswithcssFilename
$path:=getXMLFolderPath+$fileName

If (Test path name:C476($path)=Is a document:K24:1)
	
	$fullpath:=Get 4D folder:C485(4D Client database folder:K5:13)+$fileName
	
	$serverprefs:=ds:C1482.ServerPrefs.all().first()
	
	$userName:=$serverprefs.ftpUserName
	$password:=$serverprefs.ftpPassword
	$hostName:=$serverprefs.ftpHostName
	$hostDirectory:=$serverprefs.ftpUploadPath
	
	$error:=FTP_Login($hostName; $userName; $password; $ftpid; $FTP_Msg)
	
	$error:=FTP_Send($ftpid; $path; ""; 0)  // this gives error "file not found"
	
	$error:=FTP_Send($ftpid; $fullpath; ""; 0)  // this works
	
	$error:=FTP_Logout($ftpid)
	
End if 

