//%attributes = {}
// getRegisterSums (->debLocal;->credLocal;->balLocal;{->fees})
// getRegisterSums (->debLocal;->credLocal;->balLocal;->fees; ->unrealizedGains)

// getRegisterSums(->debLoc;->credLoc;->balLoc;->debits;->credits;->balance;{->fees})
// getRegisterSums(->debLoc;->credLoc;->balLoc;->debits;->credits;->balance;->fees;->transferIn;->transferOut)
// getRegisterSums(->debLoc;->credLoc;->balLoc;->debits;->credits;->balance;->fees;->transferIn;->transferOut;->unrealizedGains)

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10)
C_REAL:C285($unrealizedGain; $totalDebits; $totalCredits; $balance; $totalDebitsLocal; $totalCreditsLocal; $balanceLocal; $fees; $transferIn; $transferOut)
READ ONLY:C145([Registers:10])

$totalDebitsLocal:=Sum:C1([Registers:10]DebitLocal:23)
$totalCreditsLocal:=Sum:C1([Registers:10]CreditLocal:24)
$balanceLocal:=$totalDebitsLocal-$totalCreditsLocal

$1->:=$totalDebitsLocal
$2->:=$totalCreditsLocal
$3->:=$balanceLocal

If (Count parameters:C259=4)
	$fees:=Sum:C1([Registers:10]totalFees:30)
	$4->:=$fees
End if 

If (Count parameters:C259=5)
	$fees:=Sum:C1([Registers:10]totalFees:30)
	$unrealizedGain:=Sum:C1([Registers:10]UnrealizedGain:56)
	$4->:=$fees
	$5->:=$unrealizedGain
End if 


If (Count parameters:C259>=6)
	$totalDebits:=Sum:C1([Registers:10]Debit:8)
	$totalCredits:=Sum:C1([Registers:10]Credit:7)
	$balance:=$totalDebits-$totalCredits
	
	$4->:=$totalDebits
	$5->:=$totalCredits
	$6->:=$balance
End if 

If (Count parameters:C259>=7)
	$fees:=Sum:C1([Registers:10]totalFees:30)
	$7->:=$fees
End if 

If (Count parameters:C259>=9)
	C_TEXT:C284($namedSelection)
	$namedSelection:="$reg_NamedSelection"
	COPY NAMED SELECTION:C331([Registers:10]; $namedSelection)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=True:C214)  // filter only the transfer
	$transferIn:=Sum:C1([Registers:10]Debit:8)  // how much money transferred In
	$transferOut:=Sum:C1([Registers:10]Credit:7)  // how much money transferred Out
	USE NAMED SELECTION:C332($namedSelection)  // revert the selection to where it was before
	CLEAR NAMED SELECTION:C333($namedSelection)
	$8->:=$transferIn
	$9->:=$transferOut
End if 

If (Count parameters:C259=10)
	$unrealizedGain:=Sum:C1([Registers:10]UnrealizedGain:56)
	$10->:=$unrealizedGain
End if 
