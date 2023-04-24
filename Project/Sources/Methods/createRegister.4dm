//%attributes = {}
// createRegister (invoice;duedate;registerID;registerType;isPaid;customerID;amounT;currency;accountID;->TablePtr;->comments)

C_TEXT:C284($1; $0; $registerID)
C_DATE:C307($dueDate; $2)
C_TEXT:C284($3; $registerType; $4; $invoiceNumber; $6; $customerID)
C_BOOLEAN:C305($5; $isReceived)
C_REAL:C285($amount; $7)
C_TEXT:C284($currency; $8; $accountID; $9)
C_POINTER:C301($tablePtr; $autoCommentPtr; $10; $11)

$invoiceNumber:=$1
$dueDate:=$2
$registerID:=$3
$registerType:=$4
$isReceived:=Not:C34($5)

$customerID:=$6
$amount:=$7
$currency:=$8
$accountID:=$9
$tablePtr:=$10
$autoCommentPtr:=$11  // the reason for this to be a pointer is performance with long text passing

READ WRITE:C146([Registers:10])

If ($registerID="")  //create
	CREATE RECORD:C68([Registers:10])
	[Registers:10]RegisterID:1:=makeRegisterID
	
Else   // load to modify
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$registerID)
	LOAD RECORD:C52([Registers:10])
End if 


[Registers:10]InvoiceNumber:10:=$InvoiceNumber
[Registers:10]OurRate:25:=vRate
[Registers:10]percentFee:28:=vPercentFee
[Registers:10]feeLocal:29:=vFeeLocal

//[Registers]SpotRate:=[Invoices]SpotRate

If ($isReceived)
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]Debit:8:=$amount
	[Registers:10]Credit:7:=0
	//[Registers]OurRate:=vFromOurBuy
	
Else 
	[Registers:10]isReceived:13:=False:C215
	[Registers:10]Debit:8:=0
	[Registers:10]Credit:7:=$amount
	//[Registers]OurRate:=vToOurSell
	
End if 

[Registers:10]RegisterType:4:=$registerType
//[Registers]SerialNo:=[eWires]eWireID
[Registers:10]CustomerID:5:=$customerID
[Registers:10]RegisterDate:2:=$dueDate
[Registers:10]AccountID:6:=$accountID
[Registers:10]InternalTableNumber:17:=Table:C252($tablePtr)
[Registers:10]InternalRecordID:18:=Field:C253([Registers:10]InternalTableNumber:17; 1)->  // first field is usually the primary key
[Registers:10]Currency:19:=$currency
If ($autoCommentPtr->#"")
	[Registers:10]AutoComments:12:=False:C215
	[Registers:10]Comments:9:=$autoCommentPtr->
Else 
	[Registers:10]AutoComments:12:=True:C214
End if 
$0:=[Registers:10]RegisterID:1

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])