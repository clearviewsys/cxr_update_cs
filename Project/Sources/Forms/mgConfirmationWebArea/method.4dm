Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.mywa:="confirmwa"
		
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable Web inspector:K62:7; True:C214)
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; _o_WA enable JavaScript:K62:4; True:C214)
		
		
		If (Form:C1466.URL#Null:C1517)
			If (Form:C1466.URL#"")
				WA OPEN URL:C1020(*; "mywa"; Form:C1466.URL)
			End if 
		End if 
		
		
		
End case 
