//%attributes = {}
C_TEXT:C284($1; $pathToFile)
C_BOOLEAN:C305($2; $skipAuthorization; $ok)
C_TEXT:C284($binaryPath; $inp; $out; $fullCMD; $bucketName)
C_OBJECT:C1216($0; $file)
C_BOOLEAN:C305($done; $isFileUploading)
C_COLLECTION:C1488($unfinishedLargeFiles)

$done:=False:C215

$pathToFile:=$1

$file:=File:C1566($pathToFile; fk platform path:K87:2)

$binaryPath:=b2_getCLIToolPath
$bucketName:=LEP_Escape(b2_getMyBucketName)

If (Count parameters:C259>1)
	$skipAuthorization:=$2
Else 
	$skipAuthorization:=False:C215
End if 

If (Not:C34($skipAuthorization))
	$ok:=b2_authorize_account
Else 
	$ok:=True:C214
End if 

If ($ok)
	
	$fullCMD:=$binaryPath+" upload_file --noProgress "+$bucketName+" "+LEP_Escape($file.path)+" "+$file.name
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
	
	LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp)
	
	While (Not:C34($done))
		
		DELAY PROCESS:C323(Current process:C322; b2_getDelay)
		
		$unfinishedLargeFiles:=b2_getUnfinishedlargeFiles
		
		$isFileUploading:=b2_isFileinUnfinishedFiles($file.name; $unfinishedLargeFiles)
		
		If (Not:C34($isFileUploading))
			$done:=True:C214
		End if 
		
	End while 
	
End if 
