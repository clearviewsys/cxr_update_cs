//%attributes = {}
// cancels uplaod of large file that is still in progress

C_TEXT:C284($1; $fileId; $fullCMD)
C_BOOLEAN:C305($2; $skipAuthorization; $ok)
C_TEXT:C284($binaryPath; $inp; $out; $fullCMD; $errorTxt)
C_OBJECT:C1216($0)

$fileId:=$1
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
	
	If ($out#"")  // usually "Using https://api.backblazeb2.com\n" is returned
		
		$fullCMD:=$binaryPath+" cancel_large_file "+$fileId
		
		If ($out#"")
			
			$0:=JSON Parse:C1218($out)
			
		End if 
		
	End if 
	
End if 
