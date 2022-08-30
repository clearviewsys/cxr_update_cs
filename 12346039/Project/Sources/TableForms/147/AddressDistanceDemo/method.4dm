C_LONGINT:C283($formEvent)
C_OBJECT:C1216(pointA; pointB)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Data Change:K2:15)
		If ((pointA#Null:C1517) & (pointB#Null:C1517) & (OB Is defined:C1231(pointA; "lat")) & (OB Is defined:C1231(pointB; "lat")))
			C_OBJECT:C1216($resultObj; $errorObj)
			C_BOOLEAN:C305($success)
			$resultObj:=New object:C1471
			$errorObj:=New object:C1471
			$success:=googleGetDistance(pointA; pointB; $resultObj; $errorObj)
			C_REAL:C285($straightLineDistance)
			$straightLineDistance:=getCoordinateDistanceMath2(pointA; pointB)
			If ($success=True:C214)
				myAlert(JSON Stringify:C1217(New object:C1471("Route Distance"; $resultObj; "Straight Line Distance in Meters"; $straightLineDistance)))
			Else 
				If (Not:C34(Undefined:C82($errorObj.error_message)))
					myAlert(JSON Stringify:C1217($errorObj))
				End if 
			End if 
		End if 
End case 