C_POINTER:C301($popupPtr)
C_OBJECT:C1216($stateObj)

$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupStates")

If (Form event code:C388=On Data Change:K2:15)
	
	If ($popupPtr->>1)
		Form:C1466.state:=$popupPtr->{$popupPtr->}
		$stateObj:=Form:C1466.states[$popupPtr->-2]
		Form:C1466.stateCode:=$stateObj.StateOfCountry
	Else 
		Form:C1466.state:=""
		Form:C1466.stateCode:=""
	End if 
	
End if 
