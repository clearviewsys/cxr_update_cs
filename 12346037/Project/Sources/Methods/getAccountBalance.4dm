//%attributes = {"executedOnServer":true}
//getAccountBalance(accountID;{fromDate;toDate;applyDateRange};branchID) -> real:balance
// POST: selection of registers will be changed; table Registers will become read only
// made it run on the server instead of the client
// #ORDA

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

// Rewrote the method in ORDA for simplicity
// #ORDA
$0:=$result
C_OBJECT:C1216($es)
$es:=ds:C1482.Registers.query("AccountID = :1"; $accountID)

If ($branchID#"")
	$es:=$es.query("BranchID = :1"; $branchID)
End if 

If ($doApplyDateRange)
	$es:=$es.query("RegisterDate >= :1 AND RegisterDate <= :2"; $fromDate; $toDate)
End if 

$result:=$es.sum("Debit")-$es.sum("Credit")
$0:=$result

// #Classic
//READ ONLY([Registers])
//SET QUERY DESTINATION(Into current selection)

//QUERY([Registers];[Registers]AccountID=$accountID)


//If ($branchID#"")
//QUERY SELECTION([Registers];[Registers]BranchID=$branchID)
//End if 

//If ($doApplyDateRange)
//QUERY SELECTION([Registers];[Registers]RegisterDate>=$fromDate;*)
//QUERY SELECTION([Registers]; & ;[Registers]RegisterDate<=$toDate)
//End if 

//$totalWithdraw:=Sum([Registers]Credit)
//$totalDeposit:=Sum([Registers]Debit)
//  //$0:=roundToBase (($totalDeposit)-($totalWithdraw))

//$result:=($totalDeposit-$totalWithdraw)  // doesn't need to round