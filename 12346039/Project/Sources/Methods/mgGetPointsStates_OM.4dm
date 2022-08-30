//%attributes = {}
C_POINTER:C301($popupPtr)

Form:C1466.states:=mgGetStatesFromStorage(True:C214)
Form:C1466.states:=Form:C1466.states.query("Country = :1"; String:C10(Form:C1466.destinationCountryID))
Form:C1466.state:=""
Form:C1466.stateCode:=""

$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupStates")

ARRAY TEXT:C222($popupPtr->; 0)

If (Form:C1466.states.length>0)
	
	COLLECTION TO ARRAY:C1562(Form:C1466.states; $popupPtr->; "StateOfCountryName")
	INSERT IN ARRAY:C227($popupPtr->; 1)
	$popupPtr->{1}:="Pick state ..."
	OBJECT SET ENABLED:C1123($popupPtr->; True:C214)
	OBJECT SET VISIBLE:C603($popupPtr->; True:C214)
	$popupPtr->:=1
	OBJECT SET ENTERABLE:C238(*; "destinationState"; False:C215)
	OBJECT SET VISIBLE:C603(*; "destinationState"; False:C215)
	
Else 
	
	OBJECT SET ENABLED:C1123($popupPtr->; False:C215)
	OBJECT SET VISIBLE:C603($popupPtr->; False:C215)
	OBJECT SET ENTERABLE:C238(*; "destinationState"; True:C214)
	OBJECT SET VISIBLE:C603(*; "destinationState"; True:C214)
	
End if 
