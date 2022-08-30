//%attributes = {}
C_OBJECT:C1216($1; $data)
C_TEXT:C284($formName)
C_LONGINT:C283($winref)

$data:=$1

If ($data.object.transactionType="Send")
	$formName:="mgSend"
Else 
	$formName:="mgReceive"
End if 

$winref:=Open form window:C675($formName)
DIALOG:C40($formName; $data)

CLOSE WINDOW:C154
