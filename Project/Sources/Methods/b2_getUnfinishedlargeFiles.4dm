//%attributes = {}
C_TEXT:C284($fullCMD; $bucketName; $binaryPath; $inp; $out; $line)
C_COLLECTION:C1488($0; $lines)

$bucketName:=b2_getMyBucketName
$binaryPath:=b2_getCLIToolPath
$inp:=""

$fullCMD:=$binaryPath+" list-unfinished-large-files "+$bucketName

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

LAUNCH EXTERNAL PROCESS:C811($fullCMD; $inp; $out)

$lines:=Split string:C1554($out; "\n")

$0:=$lines

