C_POINTER:C301($self)
$self:=Self:C308

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	ALL RECORDS:C47([CashRegisters:33])
	SELECTION TO ARRAY:C260([CashRegisters:33]CashRegisterID:1; $self->)
	SORT ARRAY:C229($self->)
	
	INSERT IN ARRAY:C227($self->; 1)
	$self->{1}:="Tills"
	$self->:=1
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($till)
	$till:=$self->{$self->}
	selectAccountsRelatedToTill($till)
	If (getKeyValue("settings.filterZeroBalanceTills"; "true")="true")
		selectAccountsWithBalance  // by default filter the zero balance accounts
	End if 
	filterHiddenAccounts
	POST OUTSIDE CALL:C329(Current process:C322)
	//arrMainAccounts:=0
	//arrAccountType:=0
End if 