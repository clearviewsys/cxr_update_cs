//%attributes = {}
Form:C1466.mywa:="mywa"

If (Form:C1466.session.showProgress)
	OBJECT SET VISIBLE:C603(*; Form:C1466.mywa; True:C214)
Else 
	// OBJECT SET VISIBLE(*;Form.mywa;False)
	OBJECT SET VISIBLE:C603(*; Form:C1466.mywa; True:C214)
End if 

WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable contextual menu:K62:6; True:C214)
WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable Web inspector:K62:7; True:C214)
WA SET PREFERENCE:C1041(*; Form:C1466.mywa; _o_WA enable JavaScript:K62:4; True:C214)


SET WINDOW TITLE:C213("Connecting to MoneyGram ...")

WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.session.endpoints.loginURL)
