//%attributes = {}
// checkDownloadFolder ($logFilePath;$downloadPath)

#DECLARE($logFilePath : Text; $downloadPathPtr : Pointer)->$isFolderOk : Boolean

ARRAY TEXT:C222($arrFileNames; 0)
$isFolderOk:=True:C214

If ($downloadPathPtr->="")
	$downloadPathPtr->:=System folder:C487(Desktop:K41:16)+"_downloads"
End if 

If (Test path name:C476($downloadPathPtr->)#Is a folder:K24:2)
	CREATE FOLDER:C475($downloadPathPtr->)
	UTIL_Log("automaticUpdates"; "Folder created: "+$downloadPathPtr->)
Else 
	UTIL_Log("automaticUpdates"; "Folder exists: "+$downloadPathPtr->)
End if 

DOCUMENT LIST:C474($downloadPathPtr->; $arrFileNames; Absolute path:K24:14)

If (Test path name:C476($downloadPathPtr->+Folder separator:K24:12+".DS_Store")=Is a document:K24:1)
	DELETE DOCUMENT:C159($downloadPathPtr->+Folder separator:K24:12+".DS_Store")
	DOCUMENT LIST:C474($downloadPathPtr->; $arrFileNames; Absolute path:K24:14)
End if 

If (Size of array:C274($arrFileNames)>0)
	
	iH_Notify("Info"; "The download folder: "+$downloadPathPtr->+" must be empty to procced downloading and unzipping the new version."; 20)
	UTIL_Log("AutomaticUpdates"; "Download Folder: "+$downloadPathPtr->+" is not empty.")
	UTIL_Log("AutomaticUpdates"; "New version was not downloaded. Process Stopped.")
	$isFolderOk:=False:C215
End if 


