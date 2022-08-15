//%attributes = {"publishedWeb":true}
//searchRecordsInList (Current form table)
C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284(vSearchString)
C_LONGINT:C283(cbDeepSearch; cbSearchSelection)

If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			enableButtonIf(isUserAuthorizedToView($tablePtr); "findButton")
		: (Form event code:C388=On Clicked:K2:4)
			If (isUserAuthorizedToView($tablePtr))
				//vSearchString:=Request("Search for:")
				displaySearchDialog
				If (OK=1)
					If (cbDeepSearch=1)
						searchTableDeep($tablePtr; vSearchString; numToBoolean(cbSearchSelection))
					Else 
						executeMethodName("search"+Table name:C256($tablePtr))
					End if 
					POST OUTSIDE CALL:C329(Current process:C322)
				End if 
			Else 
				myAlert_AccessDenied
			End if 
	End case 
End if 