//%attributes = {"publishedWeb":true}

C_TEXT:C284($vPartName; $vPartMimeType; $vPartFileName; $vDestinationFolder; $webErrorMessage)
C_BLOB:C604($vPartContentBlob)
C_LONGINT:C283($i; $webMessageType)

$vDestinationFolder:=Get 4D folder:C485(HTML Root folder:K5:20)+"uploads"+Folder separator:K24:12

If (Test path name:C476($vDestinationFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($vDestinationFolder)
End if 


For ($i; 1; WEB Get body part count:C1211)  //for each part
	WEB GET BODY PART:C1212($i; $vPartContentBlob; $vPartName; $vPartMimeType; $vPartFileName)
	If ($vPartFileName#"")
		BLOB TO DOCUMENT:C526($vDestinationFolder+$vPartFileName; $vPartContentBlob)
	End if 
End for 


If (ok=1)
	
	$webErrorMessage:="Upload Successful"
	$webMessageType:=1
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
	WEB SEND FILE:C619("uploadDemo.shtml")
Else 
	$webErrorMessage:="Upload Failed"
	$webMessageType:=3
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
	WEB SEND FILE:C619("welcome.shtml")
End if 
