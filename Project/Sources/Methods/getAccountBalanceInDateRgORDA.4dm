//%attributes = {}
// getaccountbalanceInDateRange_ORDA (accountID; fromDate ; toDate ;boolApplyDate; branchID; calculationsOjb)
// This method should run on the Server side. So make sure 'Execute on Server' is on
// This method is at least 3 times faster when executed on the server side
// #ORDA

C_TEXT:C284($accountID; $1; $branchID; $5)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_OBJECT:C1216($summary; $esAll; $esOpening; $esRange; $6)

Case of 
	: (Count parameters:C259=0)
		$accountID:="Cash-USD"
		$fromDate:=newDate(1; 1; Year of:C25(Current date:C33))
		$toDate:=Current date:C33
		$applyDateRange:=True:C214
		$branchID:=""
		$summary:=New object:C1471  // must instantiate an object always before using it
		
	: (Count parameters:C259=6)
		$accountID:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$branchID:=$5
		$summary:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$esAll:=ds:C1482.Registers.query("AccountID = :1 AND RegisterDate <= :2"; $accountID; $toDate)  // The whole range up to toDate
If ($branchID#"")
	$esAll:=$esAll.query("BranchID = :1"; $branchID)
End if 

If ($applyDateRange)
	$esOpening:=$esAll.query("RegisterDate < :1"; $fromDate)  // the opening range ; doesn't include the fromDate
	$esRange:=$esAll.query("RegisterDate >= :1"; $fromDate)  // the range fromDate to toDate ; no need to restrict the toDate again as it's been done in the whole range already
	
	$summary.openingBalance:=$esOpening.sum("Debit")-$esOpening.sum("Credit")
Else 
	$esRange:=$esAll  // the range is the same as the whole thing
	$summary.openingBalance:=0
End if 

$summary.sumDebit:=$esRange.sum("Debit")
$summary.sumCredit:=$esRange.sum("Credit")
$summary.balance:=$summary.sumDebit-$summary.sumCredit+$summary.openingBalance

$summary.sumDebitLC:=$esRange.sum("DebitLocal")
$summary.sumCreditLC:=$esRange.sum("CreditLocal")
$summary.balanceLC:=$summary.sumDebitLC-$summary.sumCreditLC

$summary.sumFees:=$esRange.sum("totalFees")  // fee received in the range
$summary.sumGains:=$esRange.sum("UnrealizedGain")  // Gain during the date range

$summary.transferIn:=$esRange.query("isTransfer = true").sum("Debit")
$summary.transferOut:=$esRange.query("isTransfer = true").sum("Credit")

$summary.sumBuys:=$summary.sumDebit-$summary.transferIn
$summary.sumSells:=$summary.sumCredit-$summary.transferOut