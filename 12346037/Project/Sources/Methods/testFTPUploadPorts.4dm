//%attributes = {}
C_TEXT:C284($ftp_method; $setvalue; $keepFTPUploadPath; $path)
C_OBJECT:C1216($serverPrefs; $keepPrefs)

$path:=getSupportFilesPath+c_PanelRatesInputFilename

$serverPrefs:=ds:C1482.ServerPrefs.all().first()
$keepPrefs:=$serverPrefs.toObject()

$ftp_method:=getKeyValue("ftp.method"; "curl")  // keep value
$keepFTPUploadPath:=<>ftpUploadPath


$serverPrefs.ftpHostName:="172.104.245.51"  // Milan's Debian Proftpd server at linode.com
$serverPrefs.ftpUserName:="tiran"
$serverPrefs.ftpPassword:="cxr"
$serverPrefs.ftpUploadPath:=""
$serverPrefs.ftpUseSecure:=False:C215
$serverPrefs.ftpPortNo:=12000  // for FTP use this port
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

If (Test path name:C476($path)=Is a document:K24:1)
	
	// this is the same as clilcking on Test FTP/SFTP button in ServerPrefs
	If (ftpUpload($path; $serverPrefs.ftpUploadPath))
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 


$serverPrefs.ftpUploadPath:="/home/tiran/"  // for SFTP this must be full path on remote host
$serverPrefs.ftpUseSecure:=True:C214
$serverPrefs.ftpPortNo:=2222  // for SFTP use this port
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

If (Test path name:C476($path)=Is a document:K24:1)
	
	// this is the same as clilcking on Test FTP/SFTP button in ServerPrefs
	If (ftpUpload($path; $serverPrefs.ftpUploadPath))
		myAlert("Upload to SFTP site successful")
	Else 
		myAlert("Upload to SFTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 


// restore ServerPrefs

$setvalue:=setKeyValue("ftp.method"; $ftp_method)

$serverPrefs.fromObject($keepPrefs)
$serverPrefs.save()

<>ftpUploadPath:=$keepFTPUploadPath
