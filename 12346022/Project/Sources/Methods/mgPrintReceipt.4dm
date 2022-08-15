//%attributes = {}
C_LONGINT:C283($winref)
C_OBJECT:C1216($formObj)
C_TEXT:C284($1; $2)

$formObj:=New object:C1471
$formObj.receiptURL:=$1
$formObj.receiptHTML:=$2

$winref:=Open form window:C675("mgPrintReceipt")
DIALOG:C40("mgPrintReceipt"; $formObj)

CLOSE WINDOW:C154
