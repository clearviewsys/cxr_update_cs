//%attributes = {}
C_TEXT:C284($1; $pathToFile)
C_TEXT:C284($binaryPath; $inp; $out; $fullCMD; $bucketName)
C_OBJECT:C1216($0; $file)
C_BOOLEAN:C305($2; $skipAuthorization; $ok)

$pathToFile:=$1

$file:=File:C1566($pathToFile; fk platform path:K87:2)
$bucketName:=LEP_Escape(b2_getMyBucketName)
$binaryPath:=b2_getCLIToolPath

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
	
	$fullCMD:=$binaryPath+" upload_file --noProgress "+$bucketName+" "+LEP_Escape($file.path)+" "+$file.fullName
	
	LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out)
	
	If ($out#"")
		
		$0:=b2_parseB2UploadOutput($out)
		
	End if 
	
End if 
