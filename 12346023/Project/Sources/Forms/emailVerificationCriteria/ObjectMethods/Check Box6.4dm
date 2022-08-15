C_COLLECTION:C1488($tempColl)

If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.skipValidEmails=False:C215)
		If (Form:C1466.hitsLeft#-1)
			$tempColl:=New collection:C1472(Form:C1466.entitySelection.length; Form:C1466.hitsLeft)
			Form:C1466.countEmails:=$tempColl.min()
		Else 
			Form:C1466.countEmails:=Form:C1466.entitySelection.length
		End if 
	Else 
		If (Form:C1466.hitsLeft#-1)
			$tempColl:=New collection:C1472(Form:C1466.entitySelectionNonValid.length; Form:C1466.hitsLeft)
			Form:C1466.countEmails:=$tempColl.min()
		Else 
			Form:C1466.countEmails:=Form:C1466.entitySelectionNonValid.length
		End if 
	End if 
	Form:C1466.confirmationMessage:="You are about to check "+String:C10(Form:C1466.countEmails)+" email(s). Would you like to continue?"
End if 

If (Form event code:C388=On Mouse Enter:K2:33)
	Form:C1466.statusDetails:="If you check this box, emails that that have the status 'valid' will be skipped."
End if 