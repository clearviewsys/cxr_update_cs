//%attributes = {}
// bPrintRecords({->[table]})

C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Not:C34(Is nil pointer:C315($tablePtr)))
	Case of 
		: (Form event code:C388=On Load:K2:1)
			enableButtonIf(isUserAuthorizedToPrint($tablePtr); "printButton")
			
		: (Form event code:C388=On Clicked:K2:4)
			If (isUserAuthorizedToPrint($tablePtr))
				setErrorTrap("PrintRecord"; "Sorry, printing is not yet supported by this module.")
				executeMethodName("print"+Table name:C256($tablePtr))
				endErrorTrap
			Else 
				myAlert_AccessDenied
			End if 
	End case 
End if 