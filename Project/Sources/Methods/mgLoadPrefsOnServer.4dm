//%attributes = {"executedOnServer":true}
C_COLLECTION:C1488($0; $serverPrefs)
C_TEXT:C284($pathToPrefs; $json; $jsonEncrypted)
C_BLOB:C604($tmp)

$pathToPrefs:=Get 4D folder:C485(Data folder:K5:33)+"mgPrefs.json"

If (Test path name:C476($pathToPrefs)=Is a document:K24:1)
	
	$jsonEncrypted:=Document to text:C1236($pathToPrefs; "UTF-8")
	BASE64 DECODE:C896($jsonEncrypted; $tmp)
	$json:=UTIL_Decrypt($tmp)
	$serverPrefs:=JSON Parse:C1218($json; *)
	$0:=$serverPrefs
	
End if 

