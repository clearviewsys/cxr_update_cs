//%attributes = {}
//Method ENCRYPT_INFO

C_BLOB:C604($vbEncrypted; $vbPrivateKey)
C_TEXT:C284($vtEncrypted)
C_TEXT:C284($result)

$vtEncrypted:="Tiran Behrouz is one e"

TEXT TO BLOB:C554($vtEncrypted; $vbEncrypted; Mac Pascal string:K22:8)
DOCUMENT TO BLOB:C525("PrivateKey.txt"; $vbPrivateKey)
If (OK=1)
	ENCRYPT BLOB:C689($vbEncrypted; $vbPrivateKey)
	$result:=BLOB to text:C555($vbEncrypted; Mac Pascal string:K22:8)
	myAlert($result)
End if 
