//%attributes = {}
// createAccountInOuts(customerID;Date;Invoice;AccountID;Amount;Currency;isPaid)
C_TEXT:C284($customerID; $accountID; $currency; $invoiceNum; $1; $3; $4; $6)
C_DATE:C307($date; $2)
C_REAL:C285($amount; $5)
C_BOOLEAN:C305($isPaid; $7)

$customerID:=$1
$date:=$2
$InvoiceNum:=$3
$AccountID:=$4
$amount:=$5
$currency:=$6
$isPaid:=$7

READ WRITE:C146([AccountInOuts:37])
CREATE RECORD:C68([AccountInOuts:37])
[AccountInOuts:37]AccountInOutID:1:=makeAccountInOutID
[AccountInOuts:37]CustomerID:2:=$customerID
[AccountInOuts:37]Date:3:=$date
[AccountInOuts:37]InvoiceID:4:=$invoiceNum
[AccountInOuts:37]AccountID:6:=$accountID
[AccountInOuts:37]Amount:7:=$amount
[AccountInOuts:37]Currency:8:=$currency
[AccountInOuts:37]isPaid:9:=$isPaid

SAVE RECORD:C53([AccountInOuts:37])
UNLOAD RECORD:C212([AccountInOuts:37])
READ ONLY:C145([AccountInOuts:37])
