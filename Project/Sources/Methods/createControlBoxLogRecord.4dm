//%attributes = {}
// createControlBoxLog ($controlBoxId;invoiceID, invoiceno, input, output, error, isSuccessful)

C_TEXT:C284($controlBoxID; $1)
C_TEXT:C284($invoiceID; $2)
C_LONGINT:C283($invoiceNo; $3)
C_TEXT:C284($input; $4)
C_TEXT:C284($output; $5)
C_TEXT:C284($error; $6)
C_BOOLEAN:C305($isSuccessful; $7)

C_DATE:C307($date)
C_TIME:C306($time)

$controlBoxID:=$1
$date:=Current date:C33
$time:=Current time:C178
$invoiceID:=$2
$invoiceNo:=$3
$input:=$4
$output:=$5
$error:=$6
$isSuccessful:=$7

READ WRITE:C146([ControlBoxLog:68])
CREATE RECORD:C68([ControlBoxLog:68])

[ControlBoxLog:68]ControlBoxID:1:=$controlBoxID
[ControlBoxLog:68]Date:2:=$date
[ControlBoxLog:68]Time:3:=$time
[ControlBoxLog:68]InvoiceID:7:=$invoiceID
[ControlBoxLog:68]InvoiceSerial:8:=$invoiceNo
[ControlBoxLog:68]inputString:4:=$input
[ControlBoxLog:68]outputString:5:=$output
[ControlBoxLog:68]errorString:6:=$error
[ControlBoxLog:68]isSuccessful:9:=$isSuccessful

SAVE RECORD:C53([ControlBoxLog:68])
UNLOAD RECORD:C212([ControlBoxLog:68])
