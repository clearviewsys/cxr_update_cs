//%attributes = {}
// uploadXMLRatesToFTPServer (filename)

C_TEXT:C284($1; $fileName; $path; $tResult)
$fileName:=$1

//$path:=Select document("";"*";"Select File to upload";16)
$path:=getXMLFolderPath+$fileName
If (<>doUploadXMLtoFTP & isSLAValid)  // the SLA must be Valid
	
	If (Test path name:C476($path)=Is a document:K24:1)
		
		If (ftpUpload($path; <>ftpUploadPath))
			$tResult:="Rates Published successfully!"
		Else 
			$tResult:="Rates Upload FAILED!"
			notifyAlert("FTP Upload failed"; "Source Path:"+$path+CRLF+"Upload Path:"+<>ftpUploadPath; 10)
		End if 
		
		writeLog($tResult)
		
	Else 
		notifyAlert("Invalid Path!"; $path; 20)
	End if 
End if 