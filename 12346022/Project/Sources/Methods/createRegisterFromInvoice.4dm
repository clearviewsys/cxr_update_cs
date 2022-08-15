//%attributes = {}
// createRegisterFromInvoice (registerID;registerType;isReceived;customerID;amounT;TablePtr;accountID;currency;date)
// this may be obsolete

C_TEXT:C284($1; $registerID; $2; $registerType; $4; $invoiceNumber; $5; $customerID; $8; $accountID)
C_BOOLEAN:C305($3; $isReceived)
C_REAL:C285($amount; $6)
C_POINTER:C301($tablePtr; $7)
C_TEXT:C284($currency; $9)
C_DATE:C307($invoiceDate; $10)


$registerID:=$1
$registerType:=$2
$isReceived:=$3
$invoiceNumber:=$4
$customerID:=$5
$amount:=$6
$tablePtr:=$7
$accountID:=$8
$currency:=$9
$invoiceDate:=$10


READ WRITE:C146([Registers:10])

QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$registerID)
If (Records in selection:C76([Registers:10])=0)  //not found then create it
	CREATE RECORD:C68([Registers:10])
Else 
	LOAD RECORD:C52([Registers:10])
End if 

[Registers:10]RegisterID:1:=$registerID
[Registers:10]InvoiceNumber:10:=$InvoiceNumber

If ($isReceived)
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]Debit:8:=$amount
	[Registers:10]Credit:7:=0
Else 
	[Registers:10]isReceived:13:=False:C215
	[Registers:10]Debit:8:=0
	[Registers:10]Credit:7:=$amount
End if 

[Registers:10]RegisterType:4:=$registerType
//[Registers]SerialNo:=[eWires]eWireID
[Registers:10]AutoComments:12:=True:C214
[Registers:10]CustomerID:5:=$customerID
[Registers:10]RegisterDate:2:=$invoiceDate
[Registers:10]AccountID:6:=$accountID
[Registers:10]InternalTableNumber:17:=Table:C252($tablePtr)
[Registers:10]InternalRecordID:18:=Field:C253([Registers:10]InternalTableNumber:17; 1)->  // first field is usually the primary key
[Registers:10]Currency:19:=$currency

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
//createRegisterFromeWire 