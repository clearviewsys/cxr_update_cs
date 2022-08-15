//%attributes = {}


C_OBJECT:C1216($0; $o)
$o:=New object:C1471

$o.registerID:=""
$o.date:=Current date:C33
$o.branchID:=getBranchID
$o.accountID:=""
$o.subAccountID:=""
$o.debit:=0
$o.credit:=0
$o.debitLC:=0
$o.creditLC:=0
$o.baseCurrency:=<>baseCurrency
$o.currency:=""
$o.comments:="n/a"
$o.commission:=0
$o.feeLC:=0
$o.customerID:=getWalkInCustomerID

$0:=$o
