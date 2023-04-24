//%attributes = {}
// handleDD_AccountTypes (self ; fromDate ; toDate ; doApplyDateRange)

// this method is called from the Accounts.ListBox form and filters the Accounts by their main account type

#DECLARE($self : Pointer; $fromDate : Date; $toDate : Date; $applyDateRange : Boolean)

ASSERT:C1129(Count parameters:C259=4; "this method expects 4 params")

$self:=$1
$fromDate:=$2
$toDate:=$3
$applyDateRange:=$4


If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($self->; 6)
	$self->:=1
End if 

If (Form event code:C388#On Load:K2:1)
	selectAccountsInDateRange($fromDate; $toDate; $applyDateRange)
	
	If (Self:C308->#1)
		//QUERY SELECTION([Accounts]; [Accounts]AccountType=$self->{$self->}) // this is the old way
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Type:36=($self->)-1; *)  // this is the new way - first element is the title
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
		
		orderByAccounts
	End if 
	// filterHiddenAccounts
	POST OUTSIDE CALL:C329(Current process:C322)
	
End if 