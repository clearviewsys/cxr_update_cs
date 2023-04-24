//%attributes = {}
// uploadXMLRatesToFTPServer (filename)

C_TEXT:C284($1; $fileName; $path; $tResult)

C_OBJECT:C1216($status)


$fileName:=$1

//$path:=Select document("";"*";"Select File to upload";16)
$path:=getXMLFolderPath+$fileName
If (<>doUploadXMLtoFTP & isSLAValid)  // the SLA must be Valid
	
	If (Test path name:C476($path)=Is a document:K24:1)
		
		$status:=ftpUpload($path; <>ftpUploadPath)
		If ($status.success)
			$tResult:="Rates Upload SUCCESS!"
		Else 
			$tResult:="Rates Upload FAILED! Error ["+String:C10($status.status)+"]"
			notifyAlert("FTP Upload failed"; "Source Path:"+$path+CRLF+"Upload Path:"+<>ftpUploadPath; 10)
		End if 
		
		writeLog($tResult)
		
	Else 
		notifyAlert("Invalid Path!"; $path; 20)
	End if 
End if 