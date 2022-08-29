//%attributes = {}
// getAccountBalanceByBID (BranchID; accountID) -> real:balance
//  this code to runs on the server for optimal result 
// POST: This will change the current selection of registers

C_TEXT:C284($1; $branchID; $accountID; $2)

C_REAL:C285($totalWithdraw; $totalDeposit; $balance; $0)

Case of 
	: (Count parameters:C259=0)
		$branchID:="TT"
		$accountID:="Cash-USD@"
		
	: (Count parameters:C259=2)
		$branchID:=$1
		$accountID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// #ORDA didn't work 
// getbuild

C_OBJECT:C1216($es)
C_REAL:C285($result; $0)
$0:=$result
C_OBJECT:C1216($es)
If ($branchID="")
	$es:=ds:C1482.Registers.query("AccountID = :1"; $accountID)
Else 
	$es:=ds:C1482.Registers.query("BranchID = :1 and AccountID=:2"; $branchID; $accountID)  // I think there's a branch and account compound index
End if 
If ($es.length>0)
	$result:=$es.sum("Debit")-$es.sum("Credit")
End if 
$0:=$result

// The old method


//#Classic 
//READ ONLY([Registers])
//SET QUERY DESTINATION(Into current selection)
//If ($branchID#"")
//QUERY([Registers];[Registers]BranchID=$branchID;*)
//QUERY([Registers]; & ;[Registers]AccountID=$accountID)
//Else 
//QUERY([Registers];[Registers]AccountID=$accountID)  // only on account
//End if 

//If (Records in selection([Registers])>0)
//$totalWithdraw:=Sum([Registers]Credit)
//$totalDeposit:=Sum([Registers]Debit)
//$balance:=($totalDeposit-$totalWithdraw)  // doesn't need to round
//End if 