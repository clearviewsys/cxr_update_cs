//%attributes = {}
// createRecordTellerProof (tellerpoofId;curr;cashAccountID;manualBalance;isConfirmed)


C_TEXT:C284($tellerProofID; $1)
C_TEXT:C284($curr; $2)
C_TEXT:C284($cashAccountID; $3)
C_REAL:C285($manualBalance; $4)
C_BOOLEAN:C305($isConfirmed; $5)
C_REAL:C285($cashTolerance)
C_TEXT:C284($desc)
C_REAL:C285($discrepancy)


$tellerProofID:=$1
$curr:=$2
$cashAccountID:=$3
$manualBalance:=$4
$isConfirmed:=$5

$cashTolerance:=1
CREATE RECORD:C68([TellerProof:78])

[TellerProof:78]BranchID:13:=getBranchID

[TellerProof:78]TellerProofID:1:=$tellerProofID
[TellerProof:78]Currency:4:=$curr
[TellerProof:78]Date:10:=Current date:C33
[TellerProof:78]Time:11:=Current time:C178
[TellerProof:78]CashAccountID:3:=$cashAccountID
[TellerProof:78]Teller:2:=getApplicationUser
[TellerProof:78]ManualBalance:8:=$manualBalance
[TellerProof:78]SystemBalance:7:=getAccountBalance($cashAccountID)
[TellerProof:78]isEODBalance:5:=$isConfirmed

QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=$curr)  // lookup the currency to store the rate
[TellerProof:78]Historic Rate:12:=[Currencies:6]SpotRateLocal:17
$discrepancy:=(Abs:C99([TellerProof:78]ManualBalance:8-[TellerProof:78]SystemBalance:7))

If ($discrepancy<$cashTolerance)
	[TellerProof:78]isMatching:6:=True:C214
	
Else 
	[TellerProof:78]isMatching:6:=False:C215
	// create an exception report
	appendLabelString(->$desc; "Cashier name:"; [TellerProof:78]Teller:2; True:C214)
	appendLabelString(->$desc; "Date stamp:"; String:C10([TellerProof:78]Date:10)+" at "+String:C10([TellerProof:78]Time:11); True:C214)
	appendLabelString(->$desc; "Cash:"; [TellerProof:78]CashAccountID:3; True:C214)
	appendLabelString(->$desc; "Discrepancy:"; String:C10($discrepancy)+" "+[TellerProof:78]Currency:4; True:C214)
	appendLabelString(->$desc; "Value of discrepancy in "+<>BASECURRENCY+":"; String:C10($discrepancy*[TellerProof:78]Historic Rate:12); True:C214)
	
	// appendLabelString (->var;label;stringToAppend;{doNewLine?})
	If ([TellerProof:78]isEODBalance:5)
		createRecordExceptionLog(->[TellerProof:78]; "Tellerproof (EOD): "+[TellerProof:78]CashAccountID:3; [TellerProof:78]TellerProofID:1; $desc)
	Else 
		createRecordExceptionLog(->[TellerProof:78]; "Tellerproof (intraday): "+[TellerProof:78]CashAccountID:3; [TellerProof:78]TellerProofID:1; $desc)
	End if 
	
End if 
SAVE RECORD:C53([TellerProof:78])

UNLOAD RECORD:C212([TellerProof:78])
