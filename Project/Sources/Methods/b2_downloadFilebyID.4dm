//%attributes = {}
C_TEXT:C284($1; $fileID)
C_TEXT:C284($2; $path)
C_BOOLEAN:C305($3; $skipAuthorization; $ok)
C_TEXT:C284($0; $binaryPath; $inp; $out; $fullCMD)

$fileID:=$1
$path:=Convert path system to POSIX:C1106($2)

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
	
	$fullCMD:=$binaryPath+" download-file-by-id --noProgress "+$fileID+" "+$path
	
	LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out)
	
	$0:=$out
	
	
End if 
