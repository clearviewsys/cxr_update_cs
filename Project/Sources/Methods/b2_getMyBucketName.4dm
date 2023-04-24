//%attributes = {}
// C_TEXT($0; $bucketName)

#DECLARE->$bucketName : Text

$bucketName:=getKeyValue("b2.bucketName")

UTIL_Log("b2"; "Bucket name: "+$bucketName)
