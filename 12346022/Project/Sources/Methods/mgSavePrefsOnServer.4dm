//%attributes = {"executedOnServer":true}
C_COLLECTION:C1488($1; $serverPrefs)
C_TEXT:C284($pathToPrefs; $json; $jsonEncrypted)
C_BOOLEAN:C305($0)
C_LONGINT:C283($count)
C_BLOB:C604($tmp)


$pathToPrefs:=Get 4D folder:C485(Data folder:K5:33)+"mgPrefs.json"

$serverPrefs:=$1
$0:=False:C215
$count:=1

$json:=JSON Stringify:C1217($serverPrefs)
$tmp:=UTIL_Encrypt($json)
BASE64 ENCODE:C895($tmp; $jsonEncrypted)

While (Semaphore:C143("mgPREFS"; 60) & ($count<6))
	IDLE:C311
	$count:=$count+1
End while 

If ($count<6)
	
	TEXT TO DOCUMENT:C1237($pathToPrefs; $jsonEncrypted; "UTF-8")
	CLEAR SEMAPHORE:C144("mgPREFS")
	$0:=True:C214
	
End if 
