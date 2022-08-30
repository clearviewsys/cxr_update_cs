//%attributes = {}
//getAccountSumOfSells(accountID;{fromDate;toDate;applyDateRange};branchID) -> real:balance
// POST: selection of registers will be changed; table Registers will become read only
// made it run on the server instead of the client

C_TEXT:C284($1; $accountID)
C_REAL:C285($totalWithdraw; $totalDeposit; $result; $0)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($4; $doApplyDateRange)
C_TEXT:C284($5; $branchID)
Case of 
	: (Count parameters:C259=0)
		$accountID:="cash-cad"  // for testing with no params
		
	: (Count parameters:C259=1)
		$accountID:=$1
		
	: (Count parameters:C259=4)
		$accountID:=$1
		$fromDate:=$2
		$toDate:=$3
		$doApplyDateRange:=$4
		
	: (Count parameters:C259=5)
		$accountID:=$1
		$fromDate:=$2
		$toDate:=$3
		$doApplyDateRange:=$4
		$branchID:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Registers:10])
SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID)


If ($branchID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)  // non-transfer only

If ($doApplyDateRange)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
End if 


$totalWithdraw:=Sum:C1([Registers:10]Credit:7)
//$totalDeposit:=Sum([Registers]Debit)
//$0:=roundToBase (($totalDeposit)-($totalWithdraw))

$result:=$totalWithdraw  // doesn't need to round

$0:=$result
