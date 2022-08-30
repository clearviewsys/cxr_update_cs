//%attributes = {"executedOnServer":true}

C_TEXT:C284($sourceFolder; $destFolder)

If (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6)
	
	$sourceFolder:=Get 4D folder:C485(Database folder:K5:14)+"WebFolder"+Folder separator:K24:12+"custom"+Folder separator:K24:12
	If (Test path name:C476($sourceFolder)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($sourceFolder)
	End if 
	
	//copy custom files to web locations - berfore startup -- copies to WEBDECOY
	$sourceFolder:=Get 4D folder:C485(Database folder:K5:14)+"custom"+Folder separator:K24:12+"web"+Folder separator:K24:12+"customers"+Folder separator:K24:12
	If (Test path name:C476($sourceFolder)=Is a folder:K24:2)
		//$destFolder:=Get 4D folder(HTML Root folder)+"custom"+Folder separator+"customers"+Folder separator
		$destFolder:=Get 4D folder:C485(Database folder:K5:14)+"WebFolder"+Folder separator:K24:12+"custom"+Folder separator:K24:12+"customers"+Folder separator:K24:12
		copyDocuments($sourceFolder; $destFolder; True:C214)
	End if 
	
	$sourceFolder:=Get 4D folder:C485(Database folder:K5:14)+"custom"+Folder separator:K24:12+"web"+Folder separator:K24:12+"agents"+Folder separator:K24:12
	If (Test path name:C476($sourceFolder)=Is a folder:K24:2)
		//$destFolder:=Get 4D folder(HTML Root folder)+"custom"+Folder separator+"agents"+Folder separator
		$destFolder:=Get 4D folder:C485(Database folder:K5:14)+"WebFolder"+Folder separator:K24:12+"custom"+Folder separator:K24:12+"agents"+Folder separator:K24:12
		copyDocuments($sourceFolder; $destFolder; True:C214)
	End if 
	
	$sourceFolder:=Get 4D folder:C485(Database folder:K5:14)+"custom"+Folder separator:K24:12+"cxr"+Folder separator:K24:12+"email-templates"+Folder separator:K24:12
	If (Test path name:C476($sourceFolder)=Is a folder:K24:2)
		$destFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"email-templates"+Folder separator:K24:12+"custom"+Folder separator:K24:12
		copyDocuments($sourceFolder; $destFolder; True:C214)
	End if 
	
End if 