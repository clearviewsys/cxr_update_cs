C_LONGINT:C283($i)
C_POINTER:C301($self)
$self:=Self:C308
If (isUserAdministrator)
	Case of 
		: (Form event code:C388=On Clicked:K2:4)
			$i:=$self->
			If ($i>1)
				myConfirm("Are you sure you want to repopulate the list?"; "Yes"; "No")
				If (OK=1)
					Case of 
						: ($i=2)  // 
							// populateList_POT 
						: ($i=3)  // 
					End case 
				End if 
			End if 
	End case 
End if 