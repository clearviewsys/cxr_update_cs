//%attributes = {}

C_TEXT:C284($result; $result1)

If (True:C214)
	$result:=WAPI_getParameter("webEmailAddress")
	checkIfNullString(->$result; "Email.")
	$result:=WAPI_getParameter("userPassword")
	checkIfNullString(->$result; "New password.")
	$result1:=WAPI_getParameter("userPassword2")
	checkIfNullString(->$result; "Cofirmation password")
	checkIfNotEqualStrings(->$result; ->$result1; "Passwords"; True:C214)
	$result:=WAPI_getParameter("webToken")
	checkIfNullString(->$result; "Security token.")
	
Else 
	//checkIfNullString (->webEmailAddress;"Email.")
	//checkIfNullString (->user_password;"New password.")
	//checkIfNullString (->user_password2;"Cofirmation password")
	//checkIfNotEqualStrings (->user_password1;->user_password2;"Passwords";True)
	//checkIfNullString (->webToken;"Security token.")
End if 

