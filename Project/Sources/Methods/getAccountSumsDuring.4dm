//%attributes = {}
// getAccountSumsDuring ( accountID; fromDate; toDate ; filter ) : object
// returns the summary of account balance during a certain date range inclusive
// the filter object 
// this method does live calculations based on the current registers (not using cache)
// #ORDA 
// see also: getAccountOpeningBalance
// unit test: test_getAccountSumsDuring

#DECLARE($accountID : Text; $fromDate : Date; $toDate : Date; $filter : Object)->$sums : Object

var $es : Object
var $query; $settings : Text
var $params : Object

$params:=New object:C1471

/*
PRE: filter object must have the following properties
filter.branchID : text
filter.subAccountID : text
filter.userID : text
filter.customerID: text
*/

Case of 
	: (Count parameters:C259=0)  // test only
		$accountID:="Cash-USD"
		$fromDate:=Add to date:C393(Current date:C33; 0; 0; -1)  // yesterday
		$toDate:=Current date:C33  // today
		
	: (Count parameters:C259=1)  // the whole history of the account
		$fromDate:=!00-00-00!
		$toDate:=!00-00-00!
		
	: (Count parameters:C259=2)  // from any date to infinity without extra filters
		$toDate:=!00-00-00!
		
	: (Count parameters:C259=3)  // from a date to a date without extra filters
		
	: (Count parameters:C259=4)  // from a date to a date with extra filters
		
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
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// if the filter is not passed to this method, we will make a blank filter
$filter:=(Count parameters:C259<4) ? New object:C1471("branchID"; ""; "subAccountID"; ""; "userID"; ""; "customerID"; "") : $filter

//MARK: Ask waiking about this following line. It seems to be incorrect
//$params.parameters:=$filter  // the filter object holds the extra parameters of the query
$params.parameters:=New object:C1471


ASSERT:C1129($accountID#"")

// optimization of query

Case of 
	: (($fromDate#!00-00-00!) & ($toDate#!00-00-00!))  // during a date range (e.g. from 1/1/2022 to 1/1/2023)
		//$es:=ds.Registers.query("AccountID=:1 AND RegisterDate >= :2 AND RegisterDate <= :3 AND isCancelled = false"; 
		$query:="AccountID==:accountID AND RegisterDate >= :fromDate AND RegisterDate <= :toDate AND isCancelled == false"
		
		//$filter.branchID:="B2"
		//$filter.userID:=""
		//$filter.subAccountID:=""
		
	: (($fromDate=!00-00-00!) & ($toDate#!00-00-00!))  // starting from inception (e.g. (from 0/0/0 to 1/1/2022)
		//$es:=ds.Registers.query("AccountID=:1 AND RegisterDate<= :2 AND isCancelled == false"; $accountID; $from)
		$query:="AccountID==:accountID AND RegisterDate <= :toDate AND isCancelled == false"
		
	: (($fromDate#!00-00-00!) & ($toDate=!00-00-00!))  // all the history to infinity (e.g. from 1/1/2020 to inf)
		//$es:=ds.Registers.query("AccountID=:1 AND RegisterDate >= :2 AND isCancelled == false"; $accountID; $from)
		$query:="AccountID==:accountID AND RegisterDate >= :fromDate AND isCancelled == false"
		
	: (($fromDate=!00-00-00!) & ($toDate=!00-00-00!))  // all the history 00/00/00 to 00/00/00
		//$es:=ds.Registers.query("AccountID=:1 AND isCancelled = false"; $accountID)
		$query:="AccountID==:accountID AND isCancelled == false"
		
	Else 
		ASSERT:C1129(False:C215; "Invalid date range")
End case 

/*
[Registers]DebitLocal
[Registers]CreditLocal
[Registers]totalFees
[Registers]UnrealizedGain
[Registers]isTransfer
[Registers]isReceived
*/

//MARK: Add the Filter Object to the query with a bunch of 'AND' operator

//$query:=($filter.branchID#"") ? $query+" AND BranchID == '"+$filter.branchID+"'" : $query
$query:=($filter.branchID#"") ? $query+" AND BranchID == :branchID" : $query

//$query:=($filter.subAccountID#"") ? $query+" AND SubAccountID == '"+$filter.subAccountID+"'" : $query
$query:=($filter.subAccountID#"") ? $query+" AND SubAccountID == :subAccountID" : $query

//$query:=($filter.userID#"") ? $query+" AND CreatedByUserID == '"+$filter.userID+"'" : $query
$query:=($filter.userID#"") ? $query+" AND CreatedByUserID == :userID" : $query

//[Registers]CustomerID
$query:=($filter.customerID#"") ? $query+" AND CustomerID == :customerID" : $query



//MARK: Mapping named parameters to values
$params.parameters.accountID:=$accountID
$params.parameters.fromDate:=$fromDate
$params.parameters.toDate:=$toDate

$params.parameters.branchID:=$filter.branchID
$params.parameters.userID:=$filter.userID
$params.parameters.subAccountID:=$filter.subAccountID
$params.parameters.customerID:=$filter.customerID

//FIXME: Ask @waikin about this
//$params.parameters.filter:=$filter  // is this correct ? 

//MARK: Perform the Query 
// #orda #optimization #context
var $contextA : Object

//FIXME: apply context
// $contextA:=New object("context"; "contextA")
// ds.setRemoteContextInfo("contextA"; ds.Registers; "BranchID, CreatedByUserID, CustomerID, AccountID, SubAccountID, RegisterDate, isCancelled, Debit, Credit, DebitLocal, CreditLocal, totalFees, isReceived, isTransfer, UnrealizedGain")
// $es:=ds.Registers.query($query; $params; $contextA)// <-------------------gives a runtime error

$es:=ds:C1482.Registers.query($query; $params)  // gives a runtime error

$sums:=New object:C1471


//MARK: the Stats are set
$sums.accountID:=$accountID

//FIXME: the following line needs to be fixed and optimized #optimize
$sums.opening:=getAccountOpeningBalance($accountID; $fromDate; $filter)

$sums.transferIns:=$es.query("isTransfer=true AND isReceived=true").sum("Debit")
$sums.transferOuts:=$es.query("isTransfer=true AND isReceived=false").sum("Credit")

$sums.debits:=$es.sum("Debit")
$sums.credits:=$es.sum("Credit")

$sums.buys:=$sums.debits-$sums.transferIns  // deduct the transfer ins
$sums.sells:=$sums.credits-$sums.transferOuts  // deduct the transfer outs

$sums.debitsLC:=$es.sum("DebitLocal")
$sums.creditsLC:=$es.sum("CreditLocal")
$sums.gains:=$es.sum("UnrealizedGain")
$sums.fees:=$es.sum("totalFees")
$sums.inFlow:=$sums.debits-$sums.credits  // the flow doesn't include the opening balance
$sums.balance:=$sums.inFlow+$sums.opening