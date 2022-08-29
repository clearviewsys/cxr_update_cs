//%attributes = {"publishedWeb":true}
// bQueryRecords (->[table])


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
	If (isUserAuthorizedToView($tablePtr))
		If (hasCustomSearchForm($tablePtr))
			myConfirm("Use the search form or the advanced query editor?"; "Search Form"; "Advanced Query...")
			If (OK=1)
				FORM SET INPUT:C55($tablePtr->; "search")
				C_LONGINT:C283($winRef)
				$winRef:=Open form window:C675($tablePtr->; "search"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
				QUERY BY EXAMPLE:C292($tablePtr->; *)
				
			Else 
				QUERY:C277($tablePtr->)
			End if 
		Else 
			QUERY:C277($tablePtr->)
		End if 
		POST OUTSIDE CALL:C329(Current process:C322)
		
	Else 
		myAlert_AccessDenied
	End if 
End if 