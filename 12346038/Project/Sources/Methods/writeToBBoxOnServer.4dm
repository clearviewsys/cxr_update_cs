//%attributes = {}
// this method get executed on the client machine
// it calls the server to write to the control unit and waits to receive the results 

C_TEXT:C284($cashier; $1)
C_TEXT:C284($posID; $2)
C_LONGINT:C283($invoiceNo; $3)
C_REAL:C285($debitLocal; $4)
C_REAL:C285($creditLocal; $5)
C_TEXT:C284($invoiceID; $6)
C_POINTER:C301($resultStringPtr; $7)
C_BOOLEAN:C305($isCopy; $8)
C_DATE:C307($invoiceDate; $9)
C_TIME:C306($invoiceTime; $10)

C_BOOLEAN:C305($success; $0)
C_LONGINT:C283($serverPID)
C_TEXT:C284($resultString)

$cashier:=Quotify($1)
$posID:=Quotify($2)
$invoiceNo:=$3
$debitLocal:=$4
$creditLocal:=$5
$invoiceID:=$6
$resultStringPtr:=$7
$isCopy:=$8
$invoiceDate:=$9
$invoiceTime:=$10


$serverPID:=Execute on server:C373("writeToBBox"; 64*1024; "writeToBBox_Process"; $cashier; $posID; [Invoices:5]serialNo_ControlBox:49; $debitLocal; $creditLocal; $invoiceID; $resultStringPtr; $isCopy; $invoiceDate; $invoiceTime; *)  // * the process should be unique

//C_TEXT($resultString;$output;$errorString)
//C_LONGINT($i)
// at this point since the process is running asynchronously, we should wait till the result gets ready
// the resulting errorcode is in spResultControlString
//Repeat 
//DELAY PROCESS(Current process;10)  ` wait a little for the result to be prepared
//  `GET PROCESS VARIABLE($serverPID;spResultControlString;$resultString)
//GET PROCESS VARIABLE(-$serverPID;spOutputString;$output;spErrorString;$errorString;spSuccess;$success)
//$i:=$i+1
//Until (($output#"") | ($errorString#"") | ($i>10))

C_TEXT:C284($resultString; $output; $errorString)
C_LONGINT:C283($i)
C_BOOLEAN:C305($found; $success)

Repeat 
	DELAY PROCESS:C323(Current process:C322; 10)  // wait a little for the result to be prepared
	$found:=getControlBoxOutputByInvoiceID($invoiceID; ->$output; ->$errorString; ->$success)
	$i:=$i+1
Until (($output#"") | ($errorString#"") | ($i>55) | ($found=True:C214))

//$resultStringPtr->:=spResultControlString
If ($success)
	$resultStringPtr->:=$output
Else 
	$resultStringPtr->:=$errorString
End if 
$0:=$success
