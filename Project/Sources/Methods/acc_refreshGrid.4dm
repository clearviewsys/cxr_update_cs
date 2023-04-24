//%attributes = {}
// this method only work in the context of the new Accounts.Grid form
// This method fills out the frid listbox arrays with values. 

// there are two kinds of filters 
// 1- filter on accounts: these are performed to display the accounts on the grid (e.g. form.filterEFT)
// 2- filter on registers : these are done on the registers (e.g. form.filter.userID) 
// 

// #context #ORDA 
// see also: 




If (False:C215)  // see also 
	acc_displayGrid
	acc_initGridFormVars
End if 

/* Field Names for [Accounts]
[Accounts]AccountID
[Accounts]isHidden
[Accounts]MainAccountID
[Accounts]AccountType
[Accounts]Currency
[Accounts]isCashAccount
[Accounts]isBankAccount
[Accounts]isChequing
[Accounts]isEFT
[Accounts]isForeignAccount
[Accounts]isPendingAccount
[Accounts]isSettlementAccount
[Accounts]isInventory
[Accounts]isInternational
*/


var $n; $i; $m : Integer
var $search; $query : Text
var $account; $accounts; $filter; $contextA : Object

//MARK: Initialize $filter from Form Vars
$filter:=New object:C1471
If (Form:C1466.applyDateRange=1)
	$fromDate:=Form:C1466.fromDate
	$toDate:=Form:C1466.toDate
Else 
	$fromDate:=!00-00-00!
	$toDate:=!00-00-00!
End if 

$filter.branchID:=Form:C1466.filter.branchID
$filter.subAccountID:=Form:C1466.filter.subAccountID
$filter.userID:=Form:C1466.filter.userID
$filter.customerID:=Form:C1466.filter.customerID

$search:=Form:C1466.searchString

var $checkboxFilters : Collection
var $checkBoxFilter : Object

// Create a collection for mapping Account attributes (fields) to form variables (filters)  from Accounts table (not Registers)
// 
$checkboxFilters:=New collection:C1472(\
New object:C1471("fieldName"; "isCashAccount"; "value"; Form:C1466.filterCash); \
New object:C1471("fieldName"; "isBankAccount"; "value"; Form:C1466.filterBank); \
New object:C1471("fieldName"; "isChequing"; "value"; Form:C1466.filterChequing); \
New object:C1471("fieldName"; "isEFT"; "value"; Form:C1466.filterEFT); \
New object:C1471("fieldName"; "isPendingAccount"; "value"; Form:C1466.filterPending); \
New object:C1471("fieldName"; "isForeignAccount"; "value"; Form:C1466.filterAgent); \
New object:C1471("fieldName"; "isInventory"; "value"; Form:C1466.filterTrade); \
New object:C1471("fieldName"; "isInternational"; "value"; Form:C1466.filterInternational); \
New object:C1471("fieldName"; "isSettlementAccount"; "value"; Form:C1466.filterSettlement); \
New object:C1471("fieldName"; "***"; "value"; 1))  // last item should be *** DO NOT CHANGE or code will fail in the for each loop


//MARK: ACCOUNTS Query string STARTS HERE
If (isUserManager)  // show all the the accounts only if the user is a manager
	$query:="(AccountID=:1 AND isHidden == false)"
Else 
	//[Accounts]isRestrictedToManagers
	$query:="(AccountID=:1 AND isHidden == false AND isRestrictedToManagers == false)"
End if 


var $flag : Boolean

//MARK: Build the query from checkbox states
If ($checkboxFilters.sum("value")>1)  // if one of the filter checkboxes were clicked we need to do a series of OR logic on them
	$query+=" AND ("
	
	For each ($checkBoxFilter; $checkboxFilters.query("value == 1"))
		
		If ($checkBoxFilter.fieldName="***")
			$query+=" ) "
			continue
		Else 
			
			If ($checkBoxFilter.value=1)
				$query+=(" OR "*Num:C11($flag))+$checkBoxFilter.fieldName+"== true "  // the OR is only set the second time
				$flag:=True:C214
			End if 
			// if not the last one then and ' OR ' to the query
		End if 
		
	End for each 
	
End if 



/*
[Accounts]Currency
[Accounts]AgentID
[Accounts]AccountType
[Accounts]MainAccountID

Form.filterCCY:=""
Form.filterTill:="" // this needs to be treated differently
Form.filterAccountType:=""
Form.filterMainAccountID:=""
Form.filterAgentID:=""
*/
var $formFilters : Collection
var $formFilter : Object

$formFilters:=New collection:C1472

$formFilters:=New collection:C1472(\
New object:C1471("fieldName"; "Currency"; "value"; Form:C1466.filterCCY); \
New object:C1471("fieldName"; "AgentID"; "value"; Form:C1466.filterAgentID); \
New object:C1471("fieldName"; "AccountType"; "value"; Form:C1466.filterAccountType); \
New object:C1471("fieldName"; "MainAccountID"; "value"; Form:C1466.filterMainAccountID))

$formFilters:=$formFilters.query("value # ''")
For each ($formFilter; $formFilters)
	$query+=" AND "+$formFilter.fieldName+" == '"+$formFilter.value+"'"
End for each 


//MARK: need to filter tills
// if filterTill is not empty, then we need to filter only
// accounts that are linked to cash-accounts that are linked to that cash register
// idea: get the collection of all accounts that are linked to the specific cash register
var $cashAccounts; $tillAccounts : 4D:C1709.EntitySelection

If (Form:C1466.filterTill#"")
	//[CashAccounts]CashRegisterID
	//[CashAccounts]AccountID
	$cashAccounts:=ds:C1482.CashAccounts.query("CashRegisterID = :1"; Form:C1466.filterTill)
	If ($cashAccounts#Null:C1517)
		$tillAccounts:=$cashAccounts.account  // this should return the entity selection of Accounts that are linked to the tills
	End if 
End if 


// MARK: Perform the Query on Accounts
$contextA:=New object:C1471("context"; "contextA")
ds:C1482.setRemoteContextInfo("contextA"; ds:C1482.Accounts; "AccountID, MainAccountID, isHidden, AccountType, Currency")
$accounts:=ds:C1482.Accounts.query($query+" order by MainAccountID, AccountID"; "@"+$search+"@"; $contextA)

If (Form:C1466.filterTill#"")
	$accounts:=$accounts.and($tillAccounts)  // if the till filter was on, then select the intersection of accounts and till accounts
End if 

$n:=$accounts.length

ARRAY BOOLEAN:C223(accountsLB; 0)
$m:=LISTBOX Get number of rows:C915(*; "accountsLB")

LISTBOX DELETE ROWS:C914(*; "accountsLB"; 1; $m)
LISTBOX INSERT ROWS:C913(*; "accountsLB"; 1; $n)

$i:=1
var $sums : Object
var $accountID : Text
var $fromDate; $toDate : Date

//MARK: Fill the ListBox arrays
var $progress : Integer

$progress:=launchProgressBar("Calculating...")

For each ($account; $accounts)
	
	arrMainAccountIDs{$i}:=$account.MainAccountID
	arrAccountIDs{$i}:=$account.AccountID
	arrCurrencies{$i}:=$account.Currency
	
	$sums:=getAccountSumsDuring($account.AccountID; $fromDate; $toDate; $filter)
	arrOpenings{$i}:=$sums.opening
	arrTransferIns{$i}:=$sums.transferIns
	arrTransferOuts{$i}:=$sums.transferOuts
	arrDebits{$i}:=$sums.debits
	arrCredits{$i}:=$sums.credits
	arrDebitsLC{$i}:=$sums.debitsLC
	arrCreditsLC{$i}:=$sums.creditsLC
	arrBalances{$i}:=$sums.balance
	arrGains{$i}:=$sums.gains
	arrFees{$i}:=$sums.fees
	
	If ($i%30=0)
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; $account.AccountID)
	End if 
	
	$i:=$i+1
End for each 
HIDE PROCESS:C324($progress)

