//%attributes = {}
// fillTPListArrays({date;{user}})


// first search for a date and teller name and then for all approved tellerproof records and then sort

// search by date and teller name

C_DATE:C307($date; $1)
C_TEXT:C284($teller; $2)

$date:=Current date:C33
$teller:=getApplicationUser

Case of 
	: (Count parameters:C259=1)
		$date:=$1
	: (Count parameters:C259=2)
		$date:=$1
		$teller:=$2
End case 

QUERY:C277([TellerProof:78]; [TellerProof:78]Date:10=$date; *)  // first by date
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]Teller:2=$teller)  // then by teller

If (cbDisplayDraft=0)  // do not display draft records (only confirmed ones)
	QUERY SELECTION:C341([TellerProof:78]; [TellerProof:78]isEODBalance:5=True:C214)  // then look for confirmed ones only
End if 

ORDER BY:C49([TellerProof:78]; [TellerProof:78]Currency:4; >; [TellerProof:78]TellerProofID:1; >)  // order by currency then by tellerproof id

C_LONGINT:C283($n)
SELECTION TO ARRAY:C260([TellerProof:78]TellerProofID:1; arrTPID; [TellerProof:78]Time:11; arrTPTime; [TellerProof:78]CashAccountID:3; arrCashAcc; [TellerProof:78]ManualBalance:8; arrManBal; [TellerProof:78]SystemBalance:7; arrSysBal; [TellerProof:78]Currency:4; arrCurr; [TellerProof:78]Historic Rate:12; arrRate)
$n:=Size of array:C274(arrTPID)
ARRAY REAL:C219(arrDiscr; $n)
ARRAY REAL:C219(arrDiscrValue; $n)

vSubtract(->arrManBal; ->arrSysBal; ->arrDiscr)  // calculate the discrepancy
vMultiply(->arrDiscr; ->arrRate; ->arrDiscrValue)  // calculate the loss



