//%attributes = {"executedOnServer":true}
C_BOOLEAN:C305($0)
C_OBJECT:C1216($key)
C_TEXT:C284($binaryPath; $inp; $out; $fullCMD; $bucketName; $err)

$0:=False:C215

$key:=b2_getKey
$binaryPath:=b2_getCLIToolPath
$bucketName:=b2_getMyBucketName

$fullCMD:=$binaryPath+" authorize-account "+$key.keyID+" "+$key.key

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out; $err)

If (($out="Using https://api.backblazeb2.com@") & ($err=""))
	
	$0:=True:C214
	
	UTIL_Log("b2"; "authorization OK, authorization $out is:\n"+$out)
	
Else 
	
	UTIL_Log("b2"; "authorization failed, authorization $out is:\n"+$out)
	UTIL_Log("b2"; "authorization $err is:\n"+$err)
End if 
