//%attributes = {}
// getAccountOpeningBalance (accountID ; date ; filter ) : real
// returns the opening balance of the account on that date
// the opening balance is the balance from day 0 to date-1
// this method calculates using #ORDA query and based on live (non-cache) data in registers
// filters can include: BranchID ; user ; sub-accounts as the same account can be used by
// ... different branchID, user, or sub-account 
// see also: getAccountSumsDuring

/*
PRE: filter object must have the following properties
filter.branchID : text
filter.subAccountID : text
filter.userID : text

*/

#DECLARE($accountID : Text; $date : Date; $filter : Object)->$balance : Real

var $es : Object
var $query : Text

$accountID:=(Count parameters:C259<2) ? "Cash-USD" : $accountID  // for testing use Cash-USD
$date:=(Count parameters:C259<2) ? Current date:C33 : $date
$filter:=(Count parameters:C259<3) ? New object:C1471("branchID"; ""; "subAccountID"; ""; "userID"; ""; "customerID"; "") : $filter

If (Count parameters:C259=3)  // if filter object is sent then make sure all attributes are valid
	If (Undefined:C82($filter.branchID))
		$filter.branchID:=""
	End if 
	If (Undefined:C82($filter.userID))
		$filter.userID:=""
	End if 
	If (Undefined:C82($filter.subAccountID))
		$filter.subAccountID:=""
	End if 
	If (Undefined:C82($filter.customerID))
		$filter.customerID:=""
	End if 
	
End if 

$query:="AccountID=:1 AND RegisterDate<= :2 AND isCancelled == false"

//[Registers]BranchID
//[Registers]SubAccountID
//[Registers]CreatedByUserID

$query:=($filter.branchID#"") ? $query+" AND BranchID =='"+$filter.branchID+"'" : $query
$query:=($filter.subAccountID#"") ? $query+" AND SubAccountID =='"+$filter.subAccountID+"'" : $query
$query:=($filter.userID#"") ? $query+" AND CreatedByUserID =='"+$filter.userID+"'" : $query
$query:=($filter.customerID#"") ? $query+" AND CustomerID =='"+$filter.customerID+"'" : $query

//fixme: this should be a key value of sort ; calculations to be using cache or live
If (Form:C1466.liveCalculations=1)
	// calculate live balance
	$es:=ds:C1482.Registers.query($query; $accountID; Add to date:C393($date; 0; 0; -1))  // opening balance means the date before
	If ($es.length>0)
		$balance:=$es.sum("Debit")-$es.sum("Credit")
	Else 
		$balance:=0
	End if 
	
Else 
	// use the cached balances from the table OpeningBalances
	$balance:=getOpeningBalance($accountID; $date)
	
End if 


