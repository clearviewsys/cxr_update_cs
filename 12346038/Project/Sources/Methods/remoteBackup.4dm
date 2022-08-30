//%attributes = {"shared":true,"executedOnServer":true}
C_OBJECT:C1216($0; $status)

$status:=New object:C1471

C_LONGINT:C283($iProcess)

If (SOAP Request:C783)
	$iProcess:=Execute on server:C373("remoteBackup"; 0; "remoteBackup")
Else 
	BACKUP:C887
End if 

//$0:="Backup Started"

$status.success:=True:C214
$status.statusText:="Backup Started"

$0:=$status