C_POINTER:C301($self)
$self:=->arrMainAccounts

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	ALL RECORDS:C47([MainAccounts:28])
	SELECTION TO ARRAY:C260([MainAccounts:28]MainAccountID:1; $self->)
	INSERT IN ARRAY:C227($self->; 1)
	$Self->{1}:="All Non-zero balance accounts"
	$Self->:=0
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	selectAccountsInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	
	If ($Self->#1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]MainAccountID:2=$Self->{$Self->})
		orderByAccounts
	End if 
	
	fillAdjustmentArrays2
	
End if 
