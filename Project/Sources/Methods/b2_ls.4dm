//%attributes = {"executedOnServer":true}
// lists the contents of our bucket. returns collection of objects received from B2

// C_COLLECTION($0; $files)
// C_BOOLEAN($1; $skipAuthorization)

#DECLARE($skipAuthorization : Boolean)->$files : Collection

var $ok : Boolean
var $binaryPath; $inp; $out; $fullCMD; $bucketName; $err : Text

//If (Count parameters>1)
//$skipAuthorization:=$1
//Else 
//$skipAuthorization:=False
//End if 

If (Count parameters:C259=0)
	$skipAuthorization:=False:C215
End if 

If (Not:C34($skipAuthorization))
	$ok:=b2_authorize_account
Else 
	$ok:=True:C214
End if 

If ($ok)
	
	$binaryPath:=b2_getCLIToolPath
	$bucketName:=b2_getMyBucketName
	
	$fullCMD:=$binaryPath+" ls --json "+$bucketName
	
	LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out; $err)
	
	If ($out#"")
		
		$files:=JSON Parse:C1218($out)
		
	End if 
	
	$0:=$files
	
End if 
