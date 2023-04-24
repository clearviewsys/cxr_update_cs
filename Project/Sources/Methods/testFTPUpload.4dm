//%attributes = {}
C_TEXT:C284($ftp_method; $setvalue; $keepFTPUploadPath; $path)
C_OBJECT:C1216($serverPrefs; $keepPrefs)

C_OBJECT:C1216($status)

$keepFTPUploadPath:=<>ftpUploadPath

$serverPrefs:=ds:C1482.ServerPrefs.all().first()
$keepPrefs:=$serverPrefs.toObject()

// set milan preferences

$serverPrefs.ftpHostName:="clearviewsys.4d.rs"
$serverPrefs.ftpUserName:="tiranb"
$serverPrefs.ftpPassword:="elfin-fed-aunt"
$serverPrefs.ftpUploadPath:="/rates/"
$serverPrefs.ftpUseSecure:=False:C215
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

$path:=getSupportFilesPath+c_PanelRatesInputFilename

$ftp_method:=getKeyValue("ftp.method"; "curl")  // keep value

$setvalue:=setKeyValue("ftp.method"; "curl")

// non-secure curl test
If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 

uploadXMLRatesToFTPServer(c_rateswithcssFilename)

// non-secure 4DIC

$setvalue:=setKeyValue("ftp.method"; "4DIC")

If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 
uploadXMLRatesToFTPServer(c_rateswithcssFilename)

$serverPrefs.ftpUploadPath:="/home/tiranb/rates/"  // remote path must be absolute for SFTP protocol
$serverPrefs.ftpUseSecure:=True:C214
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

// secure curl test
If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 

uploadXMLRatesToFTPServer(c_rateswithcssFilename)

// secure 4DIC (this actually should use curl

$setvalue:=setKeyValue("ftp.method"; "4DIC")

If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 
uploadXMLRatesToFTPServer(c_rateswithcssFilename)



$serverPrefs.ftpUploadPath:="/rates/folder1/"
$serverPrefs.ftpUseSecure:=False:C215
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

$setvalue:=setKeyValue("ftp.method"; "curl")

// non-secure curl test into subfolder

If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 

uploadXMLRatesToFTPServer(c_rateswithcssFilename)

// non-secure 4DIC into subfolder

$setvalue:=setKeyValue("ftp.method"; "4DIC")

If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 
uploadXMLRatesToFTPServer(c_rateswithcssFilename)

$serverPrefs.ftpUploadPath:="/home/tiranb/rates/folder2/"  // remote path must be absolute for SFTP protocol
$serverPrefs.ftpUseSecure:=True:C214
$serverPrefs.save()
<>ftpUploadPath:=$serverPrefs.ftpUploadPath

$setvalue:=setKeyValue("ftp.method"; "curl")

// secure curl test into subfolder

If (Test path name:C476($path)=Is a document:K24:1)
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 

uploadXMLRatesToFTPServer(c_rateswithcssFilename)

// secure 4DIC into subfolder (this actually should use curl

$setvalue:=setKeyValue("ftp.method"; "4DIC")

If (Test path name:C476($path)=Is a document:K24:1)
	
	$status:=ftpUpload($path; $serverPrefs.ftpUploadPath)
	If ($status.success)
		myAlert("Upload to FTP site successful")
	Else 
		myAlert("Upload to FTP Server Failed!")
	End if 
Else 
	myAlert($path+" doesn't exist")
End if 
uploadXMLRatesToFTPServer(c_rateswithcssFilename)

$setvalue:=setKeyValue("ftp.method"; $ftp_method)

$serverPrefs.fromObject($keepPrefs)
$serverPrefs.save()

<>ftpUploadPath:=$keepFTPUploadPath
