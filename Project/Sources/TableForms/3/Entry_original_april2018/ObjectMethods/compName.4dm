C_LONGINT:C283($found)
Self:C308->:=removeEnclosingSpaces(toTitleCase(Self:C308))
SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
QUERY:C277([Customers:3]; [Customers:3]CompanyName:42=Self:C308->)
If ($found>=1)
	myAlert("This company already exist in the database.")
	GOTO OBJECT:C206(Self:C308->)
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If (Form event code:C388=On Data Change:K2:15)
	slold_screenCompany
End if 