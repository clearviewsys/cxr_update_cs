//%attributes = {"executedOnServer":true}
C_TEXT:C284($0; $folder)

$folder:=getKeyValue("b2.downloadFolder")

If ($folder="")
	$0:=Get 4D folder:C485(Data folder:K5:33)+"b2_downloads"
Else 
	$0:=$folder
End if 

If (Test path name:C476($0)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($0)
End if 

$0:=$0+Folder separator:K24:12
