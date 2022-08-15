C_COLLECTION:C1488($tempCollection)

If (Form event code:C388=On Load:K2:1)
	
	// Validating criteria
	Form:C1466.valid:=True:C214
	Form:C1466.catchAll:=False:C215
	Form:C1466["catch-all"]:=False:C215
	Form:C1466.spamtrap:=False:C215
	Form:C1466.abuse:=False:C215
	Form:C1466.do_not_mail:=False:C215
	
	If (Form:C1466.hitsLeft#-1)
		$tempCollection:=New collection:C1472(Form:C1466.setSize; Form:C1466.hitsLeft)
		Form:C1466.countEmails:=$tempCollection.min()
		Form:C1466.hitsLeftString:="You have "+String:C10(Form:C1466.hitsLeft)+" verifications left."
	End if 
	Form:C1466.skipValidEmails:=False:C215
	Form:C1466.confirmationMessage:="You are about to check "+String:C10(Form:C1466.countEmails)+" email(s). Would you like to continue?"
	Form:C1466.statusDetails:="(Hover over and option to see more details)"
End if 