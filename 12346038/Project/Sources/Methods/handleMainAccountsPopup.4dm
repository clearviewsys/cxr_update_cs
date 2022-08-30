//%attributes = {}

C_POINTER:C301($self)
$self:=$1

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrMainAccounts; 0)  // Jan 17, 2012 12:42:20 -- I.Barclay Berry -- compiler was making this C_REAL
	
	ARRAY TEXT:C222($self->; 0)
	ALL RECORDS:C47([MainAccounts:28])
	ORDER BY:C49([MainAccounts:28]; [MainAccounts:28]MainAccountID:1)  // need to order the names of accounts alphabetically
	
	SELECTION TO ARRAY:C260([MainAccounts:28]MainAccountID:1; $self->)
	INSERT IN ARRAY:C227($self->; 1)
	$Self->{1}:="Ledger Accounts"
	$Self->:=1
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	selectAccountsInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	
	If ($Self->#1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]MainAccountID:2=$Self->{$Self->})
		orderByAccounts
	End if 
	filterHiddenAccounts
	//acc_fillAccouctsListBox 
	arrAccountType:=0
	arrCurrencies:=0
	POST OUTSIDE CALL:C329(Current process:C322)
	
End if 

