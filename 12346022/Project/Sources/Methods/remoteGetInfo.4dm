//%attributes = {"shared":true}



C_OBJECT:C1216($0; $status)

C_LONGINT:C283($iProcess)
C_TEXT:C284($tMethodName; $tInfo)

$status:=New object:C1471

$tMethodName:=Current method name:C684
$tInfo:=""

If (SOAP Request:C783)
	$iProcess:=Execute on server:C373($tMethodName; 0; $tMethodName)
Else 
	
End if 

//$0:=$tInfo

$status.success:=True:C214
$status.statusText:=$tInfo

$0:=$status