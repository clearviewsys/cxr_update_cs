//%attributes = {"shared":true,"executedOnServer":true}
C_OBJECT:C1216($0; $status)


C_LONGINT:C283($iProcess)
C_TEXT:C284($tMethodName)


$status:=New object:C1471


$tMethodName:=Current method name:C684

If (SOAP Request:C783)
	$iProcess:=Execute on server:C373($tMethodName; 0; $tMethodName)
Else 
	VERIFY CURRENT DATA FILE:C1008
End if 

//$0:="Verification Started"

$status.success:=True:C214
$status.statusText:="Verification Started"

$0:=$status