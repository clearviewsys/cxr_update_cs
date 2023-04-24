//%attributes = {}
// handleMainAccountsPopup


#DECLARE($self : Pointer; $fromDate : Date; $toDate : Date; $applyDateRange : Boolean)

ASSERT:C1129(Count parameters:C259=4; "this method expects 4 params")

$self:=$1
$fromDate:=$2
$toDate:=$3
$applyDateRange:=$4

If (Form event code:C388=On Load:K2:1)
	
	ARRAY TEXT:C222($self->; 0)
	ALL RECORDS:C47([MainAccounts:28])
	ORDER BY:C49([MainAccounts:28]; [MainAccounts:28]MainAccountID:1)  // need to order the names of accounts alphabetically
	
	SELECTION TO ARRAY:C260([MainAccounts:28]MainAccountID:1; $self->)
	INSERT IN ARRAY:C227($self->; 1)
	$Self->{1}:="Main Accounts"
	$Self->:=1
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	selectAccountsInDateRange($fromDate; $toDate; $applyDateRange)
	
	If ($Self->#1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]MainAccountID:2=$Self->{$Self->}; *)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
		
		orderByAccounts
	End if 
	
	POST OUTSIDE CALL:C329(Current process:C322)
	
End if 

