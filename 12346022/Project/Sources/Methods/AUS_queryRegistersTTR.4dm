//%attributes = {}
// AUS_queryRegistersTTR (customerID;fromdate; toDate): returns the sum of debitLC
// this method queries Registers that are cash only and related to a customer on a specific date
// aggregate customer cash transaction on a specific date

C_TEXT:C284($customerID; $1)
C_DATE:C307($date; $2; $toDate; $3)
C_REAL:C285($sumDebitLC; $0)


Case of 
	: (Count parameters:C259=0)
		$customerID:="TTCUS1029221"
		$date:=Current date:C33
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$date:=$2
		$toDate:=$date
		
	: (Count parameters:C259=3)
		$customerID:=$1
		$date:=$2
		$toDate:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=$customerID)
If ($toDate=$date)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2=$date)  // optimized query
Else 
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$date)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$todate)
End if 

SET FIELD RELATION:C919([Registers:10]AccountID:6; Automatic:K51:4; Manual:K51:3)  // for JOIN

QUERY SELECTION BY FORMULA:C207([Registers:10]; [Accounts:9]isCashAccount:3=True:C214)  // JOIN: cash only transactions (dynamic search)
SET FIELD RELATION:C919([Registers:10]AccountID:6; Manual:K51:3; Manual:K51:3)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)  // received cash only

$sumDebitLC:=Sum:C1([Registers:10]DebitLocal:23)
FIRST RECORD:C50([Registers:10])

$0:=$sumDebitLC
