Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.mywa:="mywa"
		
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable Web inspector:K62:7; True:C214)
		//WA SET PREFERENCE(*; Form.mywa; _o_WA enable JavaScript; True)
		
		OBJECT SET VISIBLE:C603(*; "btn@"; True:C214)
		
End case 
