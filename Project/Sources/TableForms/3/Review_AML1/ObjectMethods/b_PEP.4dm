
C_TEXT:C284($result; $name)
C_LONGINT:C283($match)

$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)

If (Length:C16($name)>3)
	setErrorTrap("PEP Sanction List check failed")
	$result:=checkNameAgainstList($name; ->$match; False:C215; "PEP"; True:C214)
	myAlert($result; sl_getSanctionListResultMsg($match))
	endErrorTrap
End if 