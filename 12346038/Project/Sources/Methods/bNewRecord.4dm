//%attributes = {"publishedWeb":true}
// bNewRecord ({->[table]})

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
			enableButtonIf(isUserAuthorizedToAddRecord($tablePtr); "newButton")
			enableButtonIf(isNewButtonDisabledForTable($tablePtr); "newButton")
		: (Form event code:C388=On Clicked:K2:4)
			If (isUserAuthorizedToAddRecord($tablePtr))
				executeMethodName("newRecord"+Table name:C256($tablePtr))
				If (OK=1)
					CREATE SET:C116($tablePtr->; "$newAdded")
					USE SET:C118("$newAdded")
					CLEAR SET:C117("$newAdded")
				End if 
			Else 
				//myAlert ("You are not authorized to add any record into this table.";"Privilege Restriction")
				myAlert_AccessDenied
			End if 
	End case 
End if 
