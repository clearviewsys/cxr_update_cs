//%attributes = {"executedOnServer":true}
C_TEXT:C284($1; $fileName)
C_TEXT:C284($2; $path)
C_BOOLEAN:C305($3; $skipAuthorization; $ok)
C_TEXT:C284($0; $binaryPath; $inp; $out; $bucket; $fullCMD; $err)

$fileName:=$1
$path:=LEP_Escape(Convert path system to POSIX:C1106($2))

$bucket:=b2_getMyBucketName

If (Count parameters:C259>2)
	$skipAuthorization:=$3
Else 
	$skipAuthorization:=False:C215
End if 

If (Not:C34($skipAuthorization))
	$ok:=b2_authorize_account
Else 
	$ok:=True:C214
End if 

If ($ok)
	
	$binaryPath:=b2_getCLIToolPath
	
	$fullCMD:=$binaryPath+" download-file-by-name --noProgress "+$bucket+" "+$fileName+" "+$path
	
	LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out; $err)
	
	$0:=$out
	
End if 
