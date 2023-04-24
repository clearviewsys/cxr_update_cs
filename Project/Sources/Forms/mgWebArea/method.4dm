Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		
		Form:C1466.log:=New collection:C1472
		Form:C1466.log.push(mgCreateProfixLogObject("Start ..."))
		
		Form:C1466.msg:="Starting MoneyGram connection ..."
		
		Form:C1466.mywa:="mywa"
		
		Form:C1466.WebewireID:=""
		Form:C1466.deniedURL:="XXXXX"
		
		OBJECT SET VISIBLE:C603(*; Form:C1466.mywa; False:C215)
		
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; WA enable Web inspector:K62:7; True:C214)
		WA SET PREFERENCE:C1041(*; Form:C1466.mywa; _o_WA enable JavaScript:K62:4; True:C214)
		
		If (Form:C1466.useOldLogin)
			WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.session.endpoints.loginURL)
		Else 
			WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.session.endpoints.newSession)
		End if 
		
		If (Shift down:C543)
			OBJECT SET VISIBLE:C603(*; "btn@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "btn@"; False:C215)
		End if 
		
	: (Form event code:C388=On Close Box:K2:21)
		
		If (Form:C1466.palette#Null:C1517)
			CALL FORM:C1391(Form:C1466.palette; "mgClosePalette")
		End if 
		
		If (Form:C1466.winref#Null:C1517)
			CALL FORM:C1391(Form:C1466.winref; "mgCloseDialog")
		End if 
		
		Form:C1466.log.push(mgCreateProfixLogObject("Close box clicked"))
		
		CANCEL:C270
		
End case 


