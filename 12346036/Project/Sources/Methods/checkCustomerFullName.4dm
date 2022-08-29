//%attributes = {}
//checkCustomerFullName
// new JSON version: automateSanctionChecks

C_LONGINT:C283($found)
C_TEXT:C284($fullName)

If (([Customers:3]FirstName:3#"") & ([Customers:3]LastName:4#"") & (stringHasMinimumLength([Customers:3]FirstName:3; 1)) & (stringHasMinimumLength([Customers:3]LastName:4; 1)))
	$fullName:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
	QUERY:C277([Customers:3]; [Customers:3]FullName:40=$fullName)
	If ($found>=1)
		myAlert("A customer with the name '"+$fullName+"' already exist in the database.")
		GOTO OBJECT:C206([Customers:3]FirstName:3)
		
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	CheckSanctionCheckListSetIcon(False:C215; $fullName; False:C215; Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->latestCheckStatus1)
	
	
End if 




