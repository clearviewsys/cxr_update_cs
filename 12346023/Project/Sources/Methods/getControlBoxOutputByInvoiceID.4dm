//%attributes = {}
// getControlBoxOutputByInvoiceID (invoiceID; ->outputString; ->errorString; ;->success) -> found (boolean)
// invoiceID:  
// if no result is found it returns false, otherwise it returns true
// return the result of the control box by checking the log file using the invoice no 

C_BOOLEAN:C305($found; $0)
C_TEXT:C284($invoiceID; $1)
C_POINTER:C301($outputStrPtr; $2)
C_POINTER:C301($errorStrPtr; $3)
C_POINTER:C301($successPtr; $4)

$invoiceID:=$1
$outputStrPtr:=$2
$errorStrPtr:=$3
$successPtr:=$4

READ ONLY:C145([ControlBoxLog:68])

QUERY:C277([ControlBoxLog:68]; [ControlBoxLog:68]InvoiceID:7=$invoiceID)
If (Records in selection:C76([ControlBoxLog:68])=0)  // did not find the record
	$found:=False:C215
Else   // record was found, so mutate all the pointer variables to their respective record value
	$found:=True:C214
	$outputStrPtr->:=[ControlBoxLog:68]outputString:5
	$errorStrPtr->:=[ControlBoxLog:68]errorString:6
	$successPtr->:=[ControlBoxLog:68]isSuccessful:9
End if 


$0:=$found