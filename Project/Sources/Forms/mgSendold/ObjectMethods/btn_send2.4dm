C_OBJECT:C1216($status)

Form:C1466.formName:="mgTestWebArea"
Form:C1466.mywa:="mywa"

If (Shift down:C543)
	Form:C1466.object.isDebug:="true"
End if 

mgStart

// validation of data here
//$status:=mgValidateAll(Form)

//If ($status.succes)
//mgStart
//Else 

//End if 

