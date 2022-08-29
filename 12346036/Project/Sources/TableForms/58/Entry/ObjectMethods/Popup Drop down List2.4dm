If (Form event code:C388=On Load:K2:1)
	GET FIELD TITLES:C804([Currencies:6]; arrFieldNames; arrFieldNums)
	COPY ARRAY:C226(arrFieldNames; arrFieldNames2)
	COPY ARRAY:C226(arrFieldNames; arrFieldNames3)
End if 

If (Form event code:C388=On Clicked:K2:4)
	[Ratex:58]FieldNo1:3:=arrFieldNums{arrFieldNames}
End if 