//%attributes = {}
// createCashTransactionRecord (date;cashAccount;amount;currency;isPaid;invoiceID;customerID;comments) -> cashTransactionID

C_TEXT:C284($cashTransactionID; $0)
C_DATE:C307($date; $1)
C_TEXT:C284($cashAccountID; $2)
C_REAL:C285($amount; $3)
C_TEXT:C284($currency; $4)
C_BOOLEAN:C305($isPaid; $5)
C_TEXT:C284($customerID; $comments; $invoiceID; $6; $7; $8)

$cashTransactionID:=makeCashTransactionsID
$date:=$1
$cashAccountID:=$2
$amount:=$3
$currency:=$4
$isPaid:=$5
$invoiceID:=$6
$customerID:=$7
$comments:=$8

READ WRITE:C146([CashTransactions:36])
CREATE RECORD:C68([CashTransactions:36])
[CashTransactions:36]CashTransactionID:1:=$cashTransactionID
[CashTransactions:36]Date:5:=$date
[CashTransactions:36]CashAccountID:9:=$cashAccountID
[CashTransactions:36]Amount:3:=$amount
[CashTransactions:36]Currency:4:=$currency
[CashTransactions:36]isPaid:2:=$isPaid
[CashTransactions:36]CustomerID:10:=$customerID
[CashTransactions:36]InvoiceID:7:=$invoiceID
[CashTransactions:36]comments:11:=$comments
[CashTransactions:36]UserID:6:=getApplicationUser  //<>applicationUser
SAVE RECORD:C53([CashTransactions:36])
UNLOAD RECORD:C212([CashTransactions:36])
READ ONLY:C145([CashTransactions:36])

$0:=$cashTransactionID
