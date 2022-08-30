//%attributes = {}
C_BOOLEAN:C305($err)
C_TIME:C306($doc)
C_OBJECT:C1216($obj; $serverprefs)
C_LONGINT:C283($error)
C_TEXT:C284($dir; $localpath)
C_TEXT:C284($sourcePath; $remotePath; $hostDirectory; $hostName; $userName; $password; $protocolPrefix; $ftpPort)

$serverprefs:=ds:C1482.ServerPrefs.all().first()

$userName:=$serverprefs.ftpUserName
$password:=$serverprefs.ftpPassword
$hostName:=$serverprefs.ftpHostName
$hostDirectory:=$serverprefs.ftpUploadPath

$obj:=New object:C1471

$obj.SSL_VERIFYHOST:=0
$obj.SSL_VERIFYPEER:=0

If (False:C215)
	$obj.CONNECTTIMEOUT:=10
	$obj.URL:="sftp://mail.bfpe.org/Users/testsftp/Documents/"
	$obj.USERNAME:="testsftp"
	$obj.PASSWORD:="clearviewsys"
Else 
	// test plain FTP
	$obj.CONNECTTIMEOUT:=20
	$obj.URL:="ftp://"+$hostName+"/"+$hostDirectory
	$obj.USERNAME:=$userName
	$obj.PASSWORD:=$password
End if 

$error:=cURL_FTP_GetDirList(JSON Stringify:C1217($obj); $dir)


// send file

$doc:=Open document:C264(""; Read mode:K24:5)

If (OK=1)
	
	//$err:=sftpUpload (Document;"/Users/testsftp/Documents/";"mail.bfpe.org";"testsftp";"clearviewsys")
	ASSERT:C1129(False:C215)
End if 

// get directory listing again and compare

$error:=cURL_FTP_GetDirList(JSON Stringify:C1217($obj); $dir)

// get file

$localpath:=Select folder:C670("Where to download the file?")

If (OK=1)
	
	$obj.URL:="sftp://mail.bfpe.org/Users/testsftp/Documents/test.pdf"
	
	$error:=cURL_FTP_Receive(JSON Stringify:C1217($obj); $localpath+"test.pdf")
	
	
End if 
