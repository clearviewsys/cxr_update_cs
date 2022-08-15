If (Self:C308->>0)
	Self:C308->:=calcMin(Self:C308->; Size of array:C274(arrFieldNames3))
	arrFieldNames3:=Self:C308->
Else 
	ARRFIELDNAMES3:=0
End if 

If (Not:C34(isFieldTypeNumeric(->[Currencies:6]; arrFieldNames3)) & (Self:C308->>0))
	myAlert("Field must be numeric")
	Self:C308->:=0
	ARRFIELDNAMES3:=0
End if 