//%attributes = {}
// AU_DownloadCurl
// Install Curl Command for Automatic Updates.

C_BOOLEAN:C305($0)

C_TEXT:C284($tURL; $tPath; $dummy; $tCurlFile)
C_BLOB:C604($xBlob)
C_LONGINT:C283($iError)


$dummy:=""
$0:=False:C215

$tPath:=Get 4D folder:C485(Database folder:K5:14)+"Commands"

If (Test path name:C476($tPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($tPath)
End if 

$tCurlFile:=$tPath+Folder separator:K24:12+"curl.zip"
$tURL:=getKeyValue("curlDownloadUrl"; "www.clearviewsys.com/updates/CXR/curl.zip")

$iError:=HTTP Get:C1157($tURL; $xBlob)

If ($iError=200)
	BLOB TO DOCUMENT:C526($tCurlFile; $xBlob)
	AU_UnzipFiles($tPath; ->$dummy)
	UTIL_Log("AutomaticUpdates"; "CURL installation succesfull!")
	$0:=True:C214
Else 
	UTIL_Log("AutomaticUpdates"; "CURL installation was not possible. Error="+String:C10($iError))
End if 

