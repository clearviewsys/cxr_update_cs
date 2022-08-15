C_LONGINT:C283($winRef)
Form:C1466.returnedSid:=""
Form:C1466.fromSelect:=True:C214

$winRef:=Open form window:C675("twilioCreateSubaccount"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("twilioCreateSubaccount"; Form:C1466)
CLOSE WINDOW:C154($winRef)

If (Form:C1466.returnedSid#"")
	ARRAY TEXT:C222(drop_subAccounts; 0)
	ARRAY TEXT:C222($accountNames; 0)
	ARRAY TEXT:C222(twilioSubAccounts; 0)
	
	APPEND TO ARRAY:C911(twilioSubAccounts; Form:C1466.accountSid)
	APPEND TO ARRAY:C911($accountNames; Form:C1466.accountName)
	COPY ARRAY:C226($accountNames; drop_subAccounts)
	drop_subAccounts:=1
End if 