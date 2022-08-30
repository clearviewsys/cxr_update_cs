//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// pws_createRegister (branchID;isTransfer;invoice;valueDate;accountID;customerID;debit;credit;CCY;rate;debitLocal;creditLocal;comments)
// 
C_TEXT:C284($branchID; $1)
C_BOOLEAN:C305($isTransfer; $2)
C_TEXT:C284($invoiceNumber; $3)
C_DATE:C307($valueDate; $4)

C_TEXT:C284($accountID; $5)
C_TEXT:C284($customerID; $6)
C_REAL:C285($debit; $7)
C_REAL:C285($credit; $8)

C_TEXT:C284($currency; $9)
C_REAL:C285($rate; $10)
C_REAL:C285($debitLocal; $11)
C_REAL:C285($creditLocal; $12)

C_TEXT:C284($comments; $13)

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "branchID")
SOAP DECLARATION:C782($2; Is boolean:K8:9; SOAP input:K46:1; "isTransfer")
SOAP DECLARATION:C782($3; Is text:K8:3; SOAP input:K46:1; "invoiceNo")
SOAP DECLARATION:C782($4; Is date:K8:7; SOAP input:K46:1; "valueDate")

SOAP DECLARATION:C782($5; Is text:K8:3; SOAP input:K46:1; "accountID")
SOAP DECLARATION:C782($6; Is text:K8:3; SOAP input:K46:1; "customerID")
SOAP DECLARATION:C782($7; Is real:K8:4; SOAP input:K46:1; "In")
SOAP DECLARATION:C782($8; Is real:K8:4; SOAP input:K46:1; "Out")

SOAP DECLARATION:C782($9; Is text:K8:3; SOAP input:K46:1; "currency")
SOAP DECLARATION:C782($10; Is real:K8:4; SOAP input:K46:1; "rate")
SOAP DECLARATION:C782($11; Is real:K8:4; SOAP input:K46:1; "debitLocal")
SOAP DECLARATION:C782($12; Is real:K8:4; SOAP input:K46:1; "creditLocal")

SOAP DECLARATION:C782($13; Is text:K8:3; SOAP input:K46:1; "comments")

SOAP DECLARATION:C782($0; Is text:K8:3; SOAP output:K46:2; "registerID")

$branchID:=$1
$isTransfer:=$2
$invoiceNumber:=$3
$valueDate:=$4

$accountID:=$5
$customerID:=$6
$debit:=$7
$credit:=$8

$currency:=$9
$rate:=$10
$debitLocal:=$11
$creditLocal:=$12

$comments:=$13

READ WRITE:C146([Registers:10])
C_REAL:C285($registerID)

CREATE RECORD:C68([Registers:10])
[Registers:10]RegisterID:1:=makeRegisterID

[Registers:10]BranchID:39:=$branchID
[Registers:10]isTransfer:3:=$isTransfer
[Registers:10]InvoiceNumber:10:=$InvoiceNumber

[Registers:10]RegisterDate:2:=$valueDate
[Registers:10]AccountID:6:=$accountID
[Registers:10]CustomerID:5:=$customerID

[Registers:10]Debit:8:=$debit
[Registers:10]Credit:7:=$credit
[Registers:10]Currency:19:=$currency
[Registers:10]OurRate:25:=$rate

[Registers:10]DebitLocal:23:=$debitLocal
[Registers:10]CreditLocal:24:=$creditLocal
[Registers:10]Comments:9:=$comments

//[Registers]SpotRate:=[Invoices]SpotRate

If ($debit>0)
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]RegisterType:4:="buy"
Else 
	[Registers:10]isReceived:13:=False:C215
	[Registers:10]RegisterType:4:="sell"
End if 

[Registers:10]AutoComments:12:=False:C215
[Registers:10]Comments:9:=$comments
$0:=[Registers:10]RegisterID:1

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])